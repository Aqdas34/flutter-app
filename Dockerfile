# Base image with tools
FROM ubuntu:22.04 AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl git unzip xz-utils zip libglu1-mesa wget \
  && rm -rf /var/lib/apt/lists/*

# Set Flutter version
ENV FLUTTER_VERSION=3.19.0
ENV FLUTTER_HOME=/flutter

# Download Flutter SDK
RUN git clone --depth=1 https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME


# Export path
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Enable web support
RUN flutter config --enable-web



# Set app dir
WORKDIR /app

# Copy pubspec first to cache dependencies
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the project
COPY . .

# Build web with verbose output
RUN flutter build web --verbose || (echo "Flutter build failed" && exit 1)


# Stage 2: NGINX server
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter web build
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
