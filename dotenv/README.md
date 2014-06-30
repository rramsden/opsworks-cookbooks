Dotenv Cookbook
===================

This cookbook writes out an .env file in your application root from values
set in your stack settings custom JSON

Usage
-----

Add the following keys "env" and "symlink_before_migrate" to your stack settings custom JSON

    {
        "deploy": {
            "my_app": {
                "env": {
                    "AWS_ACCESS_KEY_ID": "SOMEVALUE" 
                }
            }
        },
        "symlink_before_migrate": {
        	"config/dotenv": ".env"
        },
        ...
    }
    
Lastly, add the custom chef recipe to your ***deploy*** recipes inside your application layer in OpsWorks
 
