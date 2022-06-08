#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TadeuStore.Consumer/TadeuStore.Consumer.csproj", "TadeuStore.Consumer/"]
COPY ["TadeuStore.Domain/TadeuStore.Domain.csproj", "TadeuStore.Domain/"]
COPY ["TadeuStore.Infra.Data/TadeuStore.Infra.Data.csproj", "TadeuStore.Infra.Data/"]
RUN dotnet restore "TadeuStore.Consumer/TadeuStore.Consumer.csproj"
COPY . .
WORKDIR "/src/TadeuStore.Consumer"
RUN dotnet build "TadeuStore.Consumer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TadeuStore.Consumer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TadeuStore.Consumer.dll"]