resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "additionalProperties" = true,
        "properties" = {
            "searchAttribute" = {
                "description" = "Enter specific string to search for E.g. 'Postcode 2060'",
                "type" = "string"
            }
        },
        "required" = [
            "searchAttribute"
        ],
        "type" = "object"
    })
    contract_output = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "additionalProperties" = true,
        "properties" = {
            "contactAddress1" = {
                "type" = "string"
            },
            "contactCellPhone" = {
                "type" = "string"
            },
            "contactCity" = {
                "type" = "string"
            },
            "contactCountryCode" = {
                "type" = "string"
            },
            "contactFirstName" = {
                "type" = "string"
            },
            "contactHomePhone" = {
                "type" = "string"
            },
            "contactId" = {
                "type" = "string"
            },
            "contactLastName" = {
                "type" = "string"
            },
            "contactOrgName" = {
                "type" = "string"
            },
            "contactOrgType" = {
                "type" = "string"
            },
            "contactOtherEmail" = {
                "type" = "string"
            },
            "contactPersonalEmail" = {
                "type" = "string"
            },
            "contactPostalCode" = {
                "type" = "string"
            },
            "contactState" = {
                "type" = "string"
            },
            "contactTitle" = {
                "type" = "string"
            },
            "contactWorkEmail" = {
                "type" = "string"
            },
            "contactWorkPhone" = {
                "type" = "string"
            },
            "surveyOptOut" = {
                "type" = "boolean"
            }
        },
        "type" = "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "/api/v2/externalcontacts/contacts?q=$${input.searchAttribute}"
        
    }

    config_response {
        success_template = "{\"contactId\": $${successTemplateUtils.firstFromArray($${contactId},\"$esc.quote$esc.quote\")}, \"contactFirstName\": $${successTemplateUtils.firstFromArray($${contactFirstName},\"$esc.quote$esc.quote\")}, \"contactLastName\": $${successTemplateUtils.firstFromArray($${contactLastName},\"$esc.quote$esc.quote\")}, \"contactTitle\": $${successTemplateUtils.firstFromArray(\"$${contactTitle}\",\"$esc.quote$esc.quote\")}, \"contactPostCode\": $${successTemplateUtils.firstFromArray(\"$${contactPostCode}\",\"$esc.quote$esc.quote\")}, \"contactOrgName\": $${successTemplateUtils.firstFromArray(\"$${contactOrgName}\",\"$esc.quote$esc.quote\")}, \"contactOrgType\": $${successTemplateUtils.firstFromArray(\"$${contactOrgType}\",\"$esc.quote$esc.quote\")}, \"contactWorkPhone\": $${successTemplateUtils.firstFromArray(\"$${contactWorkPhone}\",\"$esc.quote$esc.quote\")}, \"contactCellPhone\": $${successTemplateUtils.firstFromArray(\"$${contactCellPhone}\",\"$esc.quote$esc.quote\")}, \"contactHomePhone\": $${successTemplateUtils.firstFromArray(\"$${contactHomePhone}\",\"$esc.quote$esc.quote\")}, \"contactAddress1\": $${successTemplateUtils.firstFromArray(\"$${contactAddress1}\",\"$esc.quote$esc.quote\")}, \"contactCity\": $${successTemplateUtils.firstFromArray(\"$${contactCity}\",\"$esc.quote$esc.quote\")}, \"contactState\": $${successTemplateUtils.firstFromArray(\"$${contactState}\",\"$esc.quote$esc.quote\")}, \"contactCountryCode\": $${successTemplateUtils.firstFromArray(\"$${contactCountryCode}\",\"$esc.quote$esc.quote\")}, \"surveyOptOut\": $${successTemplateUtils.firstFromArray(\"$${surveyOptOut}\",\"false\")},\"contactWorkEmail\": $${successTemplateUtils.firstFromArray(\"$${contactWorkEmail}\",\"$esc.quote$esc.quote\")},\"contactPersonalEmail\": $${successTemplateUtils.firstFromArray(\"$${contactPersonalEmail}\",\"$esc.quote$esc.quote\")},\"contactOtherEmail\": $${successTemplateUtils.firstFromArray(\"$${contactOtherEmail}\",\"$esc.quote$esc.quote\")}}"
        translation_map = { 
			contactCity = "$.entities[?(@.id != '')].address.city"
			contactId = "$.entities[?(@.id != '')].id"
			contactWorkPhone = "$.entities[?(@.id != '')].workPhone.e164"
			contactFirstName = "$.entities[?(@.id != '')].firstName"
			contactAddress1 = "$.entities[?(@.id != '')].address.address1"
			contactOrgName = "$.entities[?(@.id != '')].externalOrganization.name"
			contactCellPhone = "$.entities[?(@.id != '')].cellPhone.e164"
			contactTitle = "$.entities[?(@.id != '')].title"
			contactState = "$.entities[?(@.id != '')].address.state"
			contactHomePhone = "$.entities[?(@.id != '')].homePhone.e164"
			contactOrgType = "$.entities[?(@.id != '')].externalorganization.companyType"
			contactLastName = "$.entities[?(@.id != '')].lastName"
			contactCountryCode = "$.entities[?(@.id != '')].address.countryCode"
			contactPostCode = "$.entities[?(@.id != '')].address.postalCode"
			surveyOptOut = "$.entities[?(@.id != '')].surveyOptOut"
			contactWorkEmail = "$.entities[?(@.id != '')].workEmail"
			contactPersonalEmail = "$.entities[?(@.id != '')].personalEmail"
			contactOtherEmail = "$.entities[?(@.id != '')].otherEmail"
		}
               
    }
}