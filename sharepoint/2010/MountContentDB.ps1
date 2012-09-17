# Test required preconditions
Test-SPContentDatabase -name WSS_Content_DB -webapplication http://sitename

# Mount content db in given web application
Mount-SPContentDatabase "MyDatabase" -DatabaseServer "MyServer" -WebApplication http://sitename -UpdateUserExperience