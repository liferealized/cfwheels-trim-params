<cfcomponent output="false" mixin="dispatch">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfset this.version = "1.0" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="$createParams" access="public" returntype="struct" output="false">
		<cfargument name="route" type="string" required="true">
		<cfargument name="foundRoute" type="struct" required="true">
		<cfargument name="formScope" type="struct" required="false" default="#form#">
		<cfargument name="urlScope" type="struct" required="false" default="#url#">
		<cfscript>
			var loc = {};
			// we need the original $createParams off of the . notation so we can pass argumentCollection 
			var originalCreateParams = core.$createParams;
			
			// call our original create param method
			loc.returnValue = originalCreateParams(argumentCollection=arguments);
			
			for (loc.key in loc.returnValue)
				loc.returnValue[loc.key] = $trimParam(loc.returnValue[loc.key]);
		</cfscript>
		<cfreturn loc.returnValue />
	</cffunction>
	
	<cffunction name="$trimParam" access="public" returntype="any" output="false">
		<cfargument name="param" type="any" required="true" />
		<cfscript>
			var loc = {};
			
			// see what type we are passed, if it is not an array, struct or simple value, just return it
			if (IsArray(arguments.param)) {
			
				loc.iEnd = ArrayLen(arguments.param);
				for (loc.i=1; loc.i lte loc.iEnd; loc.i++)
					arguments.param[loc.i] = $trimParam(arguments.param[loc.i]);
			
			} else if (IsStruct(arguments.param)) {
			
				for (loc.key in arguments.param)
					arguments.param[loc.key] = $trimParam(arguments.param[loc.key]);
			
			} else if (IsSimpleValue(arguments.param)) {
			
				arguments.param = Trim(arguments.param);
			}
			
			// make sure we pass back the reference in case this is a struct or array
		</cfscript>
		<cfreturn arguments.param />
	</cffunction>
	
</cfcomponent>