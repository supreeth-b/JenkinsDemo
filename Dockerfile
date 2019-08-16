#Development Environment Process   
FROM microsoft/aspnetcore-build:latest AS build-env  
WORKDIR C:\Users\Supreeth\Source\Repos\DemoProjectAug1
 
#copy csproj and restore distinct layers,make sure that we all dependencies  
COPY *.sln ./  
RUN dotnet restore  
 
#Copy everything else and build the project in the container  
COPY . ./  

RUN DemoApplication.sln
# RUN dotnet publish --configuration Release --output dist  
 
#Deployment Environment Process   
#Build runtime image  
FROM microsoft/aspnetcore:latest  
WORKDIR /app  
COPY --from=build-env /app/dist ./  
EXPOSE 80/tcp  
ENTRYPOINT [ "dotnet","dockerapp.dll" ]  