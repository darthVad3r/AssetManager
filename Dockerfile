FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app
COPY . .
RUN dotnet restore "./assetmanager.csproj" --disable-parallel
RUN dotnet publish "./assetmanager.csproj" -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build-env /app ./

EXPOSE 5000

ENTRYPOINT [ "dotnet", "assetmanager.dll" ]