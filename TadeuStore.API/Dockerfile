#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TadeuStore.API/TadeuStore.API.csproj", "TadeuStore.API/"]
COPY ["TadeuStore.Services/TadeuStore.Services.csproj", "TadeuStore.Services/"]
COPY ["TadeuStore.Infra.CrossCutting/TadeuStore.Infra.CrossCutting.csproj", "TadeuStore.Infra.CrossCutting/"]
COPY ["TadeuStore.Domain/TadeuStore.Domain.csproj", "TadeuStore.Domain/"]
COPY ["TadeuStore.Infra.Data/TadeuStore.Infra.Data.csproj", "TadeuStore.Infra.Data/"]
RUN dotnet restore "TadeuStore.API/TadeuStore.API.csproj"
COPY . .
WORKDIR "/src/TadeuStore.API"
RUN dotnet build "TadeuStore.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TadeuStore.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TadeuStore.API.dll"]