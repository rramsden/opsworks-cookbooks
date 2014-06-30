Dotenv Cookbook
===============

This cookbook writes out an .env file in your application root from values
set in your stack settings custom JSON

Opsworks Set-Up
---------------

* Add the following keys "env" and 
"symlink_before_migrate" to your stack settings custom JSON

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
    
* Associate **dotenv** custom recipe with the **deploy** event in your rails app's layer
