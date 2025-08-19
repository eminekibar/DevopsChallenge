# 1. Build aşaması (SDK ile derleme)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore WebApplication2.csproj

COPY . .
RUN dotnet publish WebApplication2.csproj -c Release -o /app/publish

# 2. Çalıştırma aşaması (daha küçük runtime imajı)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 11130
ENTRYPOINT ["dotnet", "WebApplication2.dll"]
