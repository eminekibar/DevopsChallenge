# 1. Build aşaması (SDK ile derleme)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish WebApplication2.csproj -c Release -o /app/publish

# 2. Çalıştırma aşaması (daha küçük runtime imajı)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 5000
ENTRYPOINT ["dotnet", "WebApplication2.dll"]
