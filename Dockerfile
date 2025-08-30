# 1. Build aşaması
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Proje dosyalarını kopyala
COPY . .

# Backend ve frontend aynı publish klasörüne çıkacak
RUN dotnet publish backend/backend.csproj -c Release -o /app/publish
RUN dotnet publish frontend/frontend.csproj -c Release -o /app/publish

# 2. Çalıştırma aşaması
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Build aşamasında çıkan dosyaları kopyala
COPY --from=build /app/publish .

# Backend default portunu expose et
EXPOSE 11130

# Container başladığında backend'i çalıştır
ENTRYPOINT ["dotnet", "backend.dll"]
