# ----- Build (SDK) -----
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1) Sadece csproj'u kopyala ve restore et (cache için)
COPY WebApplication2.csproj ./
RUN dotnet restore WebApplication2.csproj

# 2) Şimdi tüm kaynakları kopyala
COPY . .

# 3) Publish: restore zaten yapıldı
RUN dotnet publish WebApplication2.csproj -c Release -o /app/publish --no-restore

# ----- Runtime (ASP.NET) -----
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 11130
ENTRYPOINT ["dotnet", "WebApplication2.dll"]
