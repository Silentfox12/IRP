﻿#language: en
@tree
@Positive
@Movements
@MovementsIncomingPaymentOrder


Feature: check Incoming payment order movements


Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _045100 preparation (Incoming payment order)
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create information register Barcodes records
		When Create catalog Companies objects (own Second company)
		When Create catalog Agreements objects
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Partners objects
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog BusinessUnits objects
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog Companies objects (second company Ferron BP)
		When Create catalog PartnersBankAccounts objects
		When update ItemKeys
		When Create catalog SerialLotNumbers objects
		When Create catalog CashAccounts objects
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company
	When Create Document discount
	* Add plugin for discount
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "DocumentDiscount" |
			When add Plugin for document discount
			When Create catalog CancelReturnReasons objects
	* Load documents
		When Create document SalesOrder objects (with aging, prepaid)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesOrder.FindByNumber(112).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document SalesOrder objects (with aging, post-shipment credit)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesOrder.FindByNumber(113).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document SalesInvoice objects (with aging, prepaid)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesInvoice.FindByNumber(112).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document SalesInvoice objects (with aging, Post-shipment credit)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesInvoice.FindByNumber(113).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document IncomingPaymentOrder objects (Cash planning)
		And I execute 1C:Enterprise script at server
			| "Documents.IncomingPaymentOrder.FindByNumber(113).GetObject().Write(DocumentWriteMode.Posting);" |
	
Scenario: _045101 check Incoming payment order movements by the Register "R3034 Cash planning (incoming)"
	* Select Incoming payment order
		Given I open hyperlink "e1cib/list/Document.IncomingPaymentOrder"
		And I go to line in "List" table
			| 'Number'  |
			| '113' |
	* Check movements by the Register  "R3034 Cash planning (outgoing)" 
		And I click "Registrations report" button
		And I select "R3033 Cash planning (incoming)" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Incoming payment order 113 dated 01.06.2021 10:53:53' | ''            | ''                    | ''          | ''             | ''                             | ''         | ''                  | ''                                            | ''              | ''                     |
			| 'Document registrations records'                       | ''            | ''                    | ''          | ''             | ''                             | ''         | ''                  | ''                                            | ''              | ''                     |
			| 'Register  "R3033 Cash planning (incoming)"'           | ''            | ''                    | ''          | ''             | ''                             | ''         | ''                  | ''                                            | ''              | ''                     |
			| ''                                                     | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                             | ''         | ''                  | ''                                            | ''              | 'Attributes'           |
			| ''                                                     | ''            | ''                    | 'Amount'    | 'Company'      | 'Multi currency movement type' | 'Currency' | 'Account'           | 'Basis'                                       | 'Movement type' | 'Deferred calculation' |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '34,24'     | 'Main Company' | 'Reporting currency'           | 'USD'      | 'Bank account, TRY' | 'Sales order 112 dated 30.05.2021 12:24:18'   | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '68,48'     | 'Main Company' | 'Reporting currency'           | 'USD'      | 'Bank account, TRY' | 'Sales invoice 113 dated 01.06.2021 10:37:58' | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '85,6'      | 'Main Company' | 'Reporting currency'           | 'USD'      | 'Bank account, TRY' | ''                                            | ''              | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '200'       | 'Main Company' | 'Local currency'               | 'TRY'      | 'Bank account, TRY' | 'Sales order 112 dated 30.05.2021 12:24:18'   | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '200'       | 'Main Company' | 'en description is empty'      | 'TRY'      | 'Bank account, TRY' | 'Sales order 112 dated 30.05.2021 12:24:18'   | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '400'       | 'Main Company' | 'Local currency'               | 'TRY'      | 'Bank account, TRY' | 'Sales invoice 113 dated 01.06.2021 10:37:58' | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '400'       | 'Main Company' | 'en description is empty'      | 'TRY'      | 'Bank account, TRY' | 'Sales invoice 113 dated 01.06.2021 10:37:58' | 'Revenue'       | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '500'       | 'Main Company' | 'Local currency'               | 'TRY'      | 'Bank account, TRY' | ''                                            | ''              | 'No'                   |
			| ''                                                     | 'Receipt'     | '01.06.2021 10:53:53' | '500'       | 'Main Company' | 'en description is empty'      | 'TRY'      | 'Bank account, TRY' | ''                                            | ''              | 'No'                   |
	And I close all client application windows

Scenario: _045102 check Incoming payment order movements by the Register "R2022 Customers payment planning" (lines with basis)
	* Select Incoming payment order
		Given I open hyperlink "e1cib/list/Document.IncomingPaymentOrder"
		And I go to line in "List" table
			| 'Number'  |
			| '113' |
	* Check movements by the Register  "R2022 Customers payment planning" 
		And I click "Registrations report" button
		And I select "R2022 Customers payment planning" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Incoming payment order 113 dated 01.06.2021 10:53:53' | ''            | ''                    | ''          | ''             | ''                                            | ''                | ''        | ''                                 |
			| 'Document registrations records'                       | ''            | ''                    | ''          | ''             | ''                                            | ''                | ''        | ''                                 |
			| 'Register  "R2022 Customers payment planning"'         | ''            | ''                    | ''          | ''             | ''                                            | ''                | ''        | ''                                 |
			| ''                                                     | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                                            | ''                | ''        | ''                                 |
			| ''                                                     | ''            | ''                    | 'Amount'    | 'Company'      | 'Basis'                                       | 'Legal name'      | 'Partner' | 'Agreement'                        |
			| ''                                                     | 'Expense'     | '01.06.2021 10:53:53' | '200'       | 'Main Company' | 'Sales order 112 dated 30.05.2021 12:24:18'   | 'Company Kalipso' | 'Kalipso' | 'Basic Partner terms, without VAT' |
			| ''                                                     | 'Expense'     | '01.06.2021 10:53:53' | '400'       | 'Main Company' | 'Sales invoice 113 dated 01.06.2021 10:37:58' | 'Company Kalipso' | 'Kalipso' | 'Basic Partner terms, without VAT' |
	And I close all client application windows