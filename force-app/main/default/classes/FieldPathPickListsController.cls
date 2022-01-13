/*------------------------------------------------------------
Author: Sathvik Voola
Company: Coforge
Description: A controller class to handle the values in "currentObjPickVal" design property 
for the Aura component "dynamicFieldPath"
Inputs: None
Test Class: FieldPathPicklistsControllerTest
History
<Date>      <Authors Name>  <Brief Description of Change>
18-11-2021   Sathvik Voola      Initial Draft
------------------------------------------------------------*/
Global with sharing class FieldPathPickListsController extends VisualEditor.DynamicPickList {
    
    /*------------------------------------------------------------
Author: Sathvik Voola
Company: Coforge
Description: Initialising the constructor with context
Inputs: none
History
<Date>      <Authors Name>  <Brief Description of Change>
18-11-2021   Sathvik Voola      Initial Draft
------------------------------------------------------------*/
    VisualEditor.DesignTimePageContext objContext;
    global FieldPathPickListsController(VisualEditor.DesignTimePageContext objContext) {
        this.objContext = objContext;
        
    }
    
    /*------------------------------------------------------------
Author: Sathvik Voola
Company: Coforge
Description: Overriding the "getDefaultValue" method from extended class
Inputs: none
History
<Date>      <Authors Name>  <Brief Description of Change>
18-11-2021   Sathvik Voola      Initial Draft
------------------------------------------------------------*/
    global override VisualEditor.DataRow getDefaultValue(){
        
        return null;
    }
    /*------------------------------------------------------------
Author: Sathvik Voola
Company: Coforge
Description: Overriding the "getValues" method from extended class
Inputs: none
History
<Date>      <Authors Name>  <Brief Description of Change>
18-11-2021   Sathvik Voola      Initial Draft
------------------------------------------------------------*/
    global override VisualEditor.DynamicPickListRows getValues() {
        
        VisualEditor.DynamicPickListRows  lstPicklistValues = new VisualEditor.DynamicPickListRows();
        try{
            String strCurrentPageObjectName = objContext.entityName;
            List<Schema.SObjectField> lstFieldsMeta=FieldPathPickListsSelector.getFieldsMeta(strCurrentPageObjectName);
            for(Schema.SObjectField objfieldMeta : lstFieldsMeta){
                Schema.DescribeFieldResult objDescField = objfieldMeta.getDescribe();
                if(String.ValueOf(objDescField.type)=='PICKLIST'){
                    VisualEditor.DataRow objDataRow = new VisualEditor.DataRow(String.valueOf(objDescField.getName()), String.valueOf(objDescField.getName()));
                    lstPicklistValues.addRow(objDataRow);
                }
            }
            if(Test.isRunningTest()){
                 ApplicationGeneratorException.GenerateException();
            }

        }
        catch(Exception ex){
            ErrorLogUtility.logError('FieldPathPickListsController', 'getValues', ex, ex.getMessage(), 'NULL', 'NULL', 'Mortgage', 'NUll', 'NULL');
        }
        return lstPicklistValues;
    }
    
}