<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DataController;
use App\Http\Controllers\ManagerUserController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\ProjectStageController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\ClientInfoController;
use App\Http\Controllers\ClientStatusController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\PurchaseReturnAllController;
use App\Http\Controllers\AccountHeadController;
use App\Http\Controllers\ReceiptAccountController;
use App\Http\Controllers\ReceiptVoucherController;
use App\Http\Controllers\PaymentAccountController;
use App\Http\Controllers\PaymentVoucherController;
use App\Http\Controllers\UnitController;
use App\Http\Controllers\PurchasedJournalController;
use App\Http\Controllers\AccountPayableJournalController;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\PurchaseLedgerController;
use App\Http\Controllers\ApLedgerController;
use App\Http\Controllers\BankLedgerController;
use App\Http\Controllers\CashLedgerController;
use App\Http\Controllers\SalesLedgerController;
use App\Http\Controllers\ReceiptPayableLedgerController;
use App\Http\Controllers\PayPayableController;
use App\Http\Controllers\PayReceivableController;
use App\Http\Controllers\GetApNameController;
use App\Http\Controllers\PurchaseReturnController;
use App\Http\Controllers\PurchaseLandController;
use App\Http\Controllers\getSupplierForCashLedger;
use App\Http\Controllers\getSupplierForBankLedger;
use App\Http\Controllers\ExpenseController;
use App\Http\Controllers\SalaryController;
use App\Http\Controllers\TrialBalanceController;
use App\Http\Controllers\getPurchaseLedgerSupplierController;
use App\Http\Controllers\getSalesLedgerSupplierController;
use App\Http\Controllers\ConsumeStockController;
use App\Http\Controllers\StockJournalController;
use App\Http\Controllers\ReferenceController;
use App\Http\Controllers\ReferenceInfoController;
use App\Http\Controllers\notificationController;
use App\Http\Controllers\AccountsAccessController;
use App\Http\Controllers\PaymentHistoryController;
use App\Http\Controllers\AdvancePayController;
use App\Http\Controllers\ConstructionRequiredController;
use App\Http\Controllers\ConstructionPayController;
use App\Http\Controllers\StockTransferController;
use App\Http\Controllers\BuildingController;
use App\Http\Controllers\FineController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('admin/register',[App\Http\Controllers\UserController::class,'register']);
Route::post('admin/login', [App\Http\Controllers\UserController::class,'authenticate']);
Route::get('admin/open', [App\Http\Controllers\DataController::class,'open']);

Route::group(['middleware' => ['jwt.verify']], function() {
    Route::get('admin/user', [App\Http\Controllers\UserController::class,'getAuthenticatedUser']);
    Route::get('admin/closed', [App\Http\Controllers\DataController::class,'closed']);
});
Route::post('manager/register',[App\Http\Controllers\ManagerUserController::class,'register']);
Route::post('manager/login', [App\Http\Controllers\ManagerUserController::class,'authenticate']);
Route::get('manager/open', [App\Http\Controllers\DataController::class,'open']);

Route::group(['middleware' => ['jwt.verify']], function() {
    Route::get('manager/user', [App\Http\Controllers\ManagerUserController::class,'getAuthenticatedUser']);
    Route::get('manager/closed', [App\Http\Controllers\ManagerDataController::class,'closed']);
});




//dashboard
Route::apiResource('/project',App\Http\Controllers\ProjectController::class);
Route::post('/updateProject',[App\Http\Controllers\ProjectController::class,'updateProject']);

Route::apiResource('/project_stage',App\Http\Controllers\ProjectStageController::class);
Route::get('/getStage/{id}',[App\Http\Controllers\GetApNameController::class,'getStage']);


Route::apiResource('/client',App\Http\Controllers\ClientInfoController::class);
Route::apiResource('/client_status',App\Http\Controllers\ClientStatusController::class);
Route::post('/client/existing_entry/',[ClientInfoController::class,'storeExist']);
Route::get('/client_info/{client_id}',[App\Http\Controllers\ClientInfoController::class,'getClientInfo']);
Route::post('/client/updateClient/',[ClientInfoController::class,'updateClient']);



Route::apiResource('/purchase_return_all',App\Http\Controllers\PurchaseReturnAllController::class);
Route::apiResource('/account_head',App\Http\Controllers\AccountHeadController::class);
Route::get('/fetch_client_project/{client_nid}',[App\Http\Controllers\ClientInfoController::class,'getProjectFromClientInfo']);

Route::apiResource('/receipt_voucher',App\Http\Controllers\ReceiptVoucherController::class);
Route::post('/receipt_voucher_update',[App\Http\Controllers\ReceiptVoucherController::class,'receiptUpdate']);


Route::apiResource('/payment_voucher',App\Http\Controllers\PaymentVoucherController::class);
Route::post('/payment_voucher_update',[App\Http\Controllers\PaymentVoucherController::class,'paymentUpdate']);
Route::apiResource('/unit',App\Http\Controllers\UnitController::class);
Route::get('/filterUnit/{itemName}',[App\Http\Controllers\UnitController::class,'filterUnit']);




// App\Http\Controllers\AccountPayableJournalController

Route::apiResource('/purchased_journal',App\Http\Controllers\PurchasedJournalController::class);
Route::post('/purchased_journal/daily_journal',[App\Http\Controllers\PurchasedJournalController::class,'perDatePurchasedVoucher']);
Route::get('/purchased_journal/getbypamentid/{payment_id}',[App\Http\Controllers\PurchasedJournalController::class,'getByPaymentId']);
Route::get('/purchased_journal/getID/{payment_id}',[App\Http\Controllers\PurchasedJournalController::class,'getID']);
Route::apiResource('/accounts_payable',App\Http\Controllers\AccountPayableJournalController::class);
Route::post('/accounts_payable/daily_journal',[App\Http\Controllers\AccountPayableJournalController::class,'fetchAccountsPayableByDate']);
Route::get('/purchased_journal/getjournal/{id}',[App\Http\Controllers\PurchasedJournalController::class,'getJournal']);
Route::get('/purchased_journal/getjournalEdit/{id}',[App\Http\Controllers\PurchasedJournalController::class,'getjournalEdit']);

//inventory
Route::apiResource('/inventory',App\Http\Controllers\InventoryController::class);
Route::post('/checkPropertyId',[App\Http\Controllers\GetApNameController::class,'checkPropertyId']);

//journal ledger
Route::apiResource('/receipt_journal',App\Http\Controllers\ReceiptJournalController::class);
Route::post('/receipt_journal/daily_journal',[App\Http\Controllers\ReceiptJournalController::class,'perDateReceiptVoucher']);
Route::get('/receipt_journal/getbyreceiptid/{receipt_id}',[App\Http\Controllers\ReceiptJournalController::class,'getByReceiptId']);
Route::get('/receipt_journal/getID/{receipt_id}',[App\Http\Controllers\ReceiptJournalController::class,'getID']);

Route::apiResource('/accounts_receivable',App\Http\Controllers\ReceiptPayableJournalController::class);

Route::post('/accounts_receivable/daily_journal',[App\Http\Controllers\ReceiptPayableJournalController::class,'fetchAccountsReceivableByDate']);
Route::apiResource('/supplier',App\Http\Controllers\SupplierController::class);
Route::apiResource('/purchase_ledger',App\Http\Controllers\PurchaseLedgerController::class);
Route::post('/purchase_ledger/pass_ldg',[App\Http\Controllers\PurchaseLedgerController::class,'receiveLdg']);
Route::apiResource('/ap_ledger',App\Http\Controllers\ApLedgerController::class);
Route::post('/ap_ledger/pass_ldg',[App\Http\Controllers\ApLedgerController::class,'receiveLdg']);
Route::apiResource('/bank_ledger',App\Http\Controllers\BankLedgerController::class);
Route::post('/bank_ledger/pass_ldg',[App\Http\Controllers\BankLedgerController::class,'receiveLdg']);
Route::apiResource('/sales_ledger',App\Http\Controllers\SalesLedgerController::class);
Route::post('/sales_ledger/pass_ldg',[App\Http\Controllers\SalesLedgerController::class,'receiveLdg']);
Route::apiResource('/rp_ledger',App\Http\Controllers\ReceiptPayableLedgerController::class);
Route::post('/rp_ledger/pass_ldg',[App\Http\Controllers\ReceiptPayableLedgerController::class,'receiveLdg']);

Route::apiResource('/cash_ledger',App\Http\Controllers\CashLedgerController::class);
Route::post('/cash_ledger/pass_ldg',[App\Http\Controllers\CashLedgerController::class,'receiveLdg']);

Route::apiResource('/pay_payable',App\Http\Controllers\PayPayableController::class);
Route::apiResource('/receipt_payable',App\Http\Controllers\PayReceivableController::class);

Route::post('/getPayableName/getJournal',[App\Http\Controllers\GetApNameController::class,'getApName']);
Route::get('/getApledger',[App\Http\Controllers\GetApNameController::class,'getApLedger']);
Route::get('/getPayableData/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getPayableData']);
Route::get('/getPaymentVoucher/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getPaymentVoucher']);
Route::get('/getPayableName/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getName']);
Route::get('/getReceiptPayableName/{receipt_id}',[App\Http\Controllers\GetApNameController::class,'getReceiptName']);

Route::get('/getPurchaseReturns/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getPurchaseReturns']);
Route::post('/filterProductType',[App\Http\Controllers\GetApNameController::class,'filterProductType']);
Route::post('/getBuildingName',[App\Http\Controllers\GetApNameController::class,'getBuildingName']);
Route::post('/getPropertyLabel',[App\Http\Controllers\GetApNameController::class,'getPropertyLabel']);
Route::post('/getPropertyId',[App\Http\Controllers\GetApNameController::class,'getPropertyId']);
Route::post('/getProductTotal',[App\Http\Controllers\GetApNameController::class,'getProductTotal']);
Route::get('/getPayableID/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getPayableID']);
Route::get('/checkDueClear/{payment_id}',[App\Http\Controllers\GetApNameController::class,'checkDueClear']);
Route::get('/checkDueClearReceipt/{receipt_id}',[App\Http\Controllers\GetApNameController::class,'checkDueClearReceipt']);

Route::get('/checkReturns/{payment_id}',[App\Http\Controllers\GetApNameController::class,'checkReturns']);
Route::get('/getFirstInstall/{payment_id}',[App\Http\Controllers\GetApNameController::class,'getFirstInstall']);
Route::get('/getFirstInstallReceipt/{receipt_id}',[App\Http\Controllers\GetApNameController::class,'getFirstInstallReceipt']);

Route::get('/getApledgerRcpt',[App\Http\Controllers\GetApNameController::class,'getApledgerRcpt']);
Route::get('/getUnit/{product_name}',[App\Http\Controllers\GetApNameController::class,'getUnit']);
Route::get('/getReference/{voucher}',[App\Http\Controllers\GetApNameController::class,'getReference']);
Route::post('/reference_clients',[App\Http\Controllers\GetApNameController::class,'reference_clients']);

Route::apiResource('/purchase_return',App\Http\Controllers\PurchaseReturnController::class);

Route::apiResource('/purchase_land_details',App\Http\Controllers\PurchaseLandController::class);

//fetch supplier for bank cash ledgers
Route::apiResource('/cash_suppliers',App\Http\Controllers\getSupplierForCashLedger::class);
Route::apiResource('/bank_suppliers',App\Http\Controllers\getSupplierForBankLedger::class);
Route::apiResource('/sales_suppliers',App\Http\Controllers\getSalesLedgerSupplierController::class);
Route::apiResource('/purchase_suppliers',App\Http\Controllers\getPurchaseLedgerSupplierController::class);
//expense

Route::apiResource('/expense',App\Http\Controllers\ExpenseController::class);
Route::post('/expense/updateExpense',[App\Http\Controllers\ExpenseController::class,'updateExpense']);
Route::post('/expense/totalExpense',[App\Http\Controllers\ExpenseController::class,'totalExpense']);

//employee
Route::apiResource('/employee',App\Http\Controllers\EmployeeController::class);
Route::post('/employee/updateEmployee',[App\Http\Controllers\EmployeeController::class,'updateEmployee']);

//salary
Route::apiResource('/salary',App\Http\Controllers\SalaryController::class);
Route::get('/salary/getSalaryHistory/{employee_id}',[App\Http\Controllers\SalaryController::class,'getSalaryHistory']);
Route::post('/salary/fetchSalary',[App\Http\Controllers\GetApNameController::class,'fetchSalary']);
Route::get('/getPurchaseAmount',[App\Http\Controllers\GetApNameController::class,'getPurchaseAmount']);

Route::post('/salary/searchByEmployee',[App\Http\Controllers\GetApNameController::class,'searchByEmployee']);

//tiral balance

Route::post('/trial_balance',[App\Http\Controllers\TrialBalanceController::class,'trialBalance']);

//calculate amount for dashboard
Route::get('/getPurchaseAmount',[App\Http\Controllers\GetApNameController::class,'getPurchaseAmount']);
Route::get('/getSalesAmount',[App\Http\Controllers\GetApNameController::class,'getSalesAmount']);
Route::get('/getPaymentDue',[App\Http\Controllers\GetApNameController::class,'getPaymentDue']);
Route::get('/getReceiptDue',[App\Http\Controllers\GetApNameController::class,'getReceiptDue']);

//pie chart
Route::get('/piechart',[App\Http\Controllers\GetApNameController::class,'pieChart']);
Route::get('/areachart',[App\Http\Controllers\GetApNameController::class,'areaChart']);

//Requisition and stock journal
Route::apiResource('/stock_journal',App\Http\Controllers\StockJournalController::class);
Route::get('/getStocks',[App\Http\Controllers\GetApNameController::class,'getStocks']);
Route::apiResource('/requisition',App\Http\Controllers\ConsumeStockController::class);
Route::get('/fetchStock/{product_name}',[App\Http\Controllers\GetApNameController::class,'fetchStock']);
Route::post('/sendForStocks',[App\Http\Controllers\GetApNameController::class,'sendForStocks']);
//member
Route::apiResource('/project_member',App\Http\Controllers\ProjectMemberController::class);
//reference
Route::apiResource('/reference',App\Http\Controllers\ReferenceController::class);
//reference info
Route::apiResource('/reference_info',App\Http\Controllers\ReferenceInfoController::class);
Route::get('/project_lists',[App\Http\Controllers\GetApNameController::class,'project_lists']);
Route::get('/fetchProjectFromLists/{id}',[App\Http\Controllers\GetApNameController::class,'fetchProjectFromLists']);
Route::get('/fetchMemberByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchMemberByProject']);

//manager approve
Route::get('/managerUsername/{username}',[App\Http\Controllers\GetApNameController::class,'managerUsername']);
Route::get('/getAllManager',[App\Http\Controllers\GetApNameController::class,'getAllManager']);
Route::apiResource('/manager_approve',App\Http\Controllers\ManagerApproveController::class);
Route::get('/getManagerProject/{username}',[App\Http\Controllers\GetApNameController::class,'getManagerProject']);
Route::get('/getManagerProjectClient/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerProjectClient']);
Route::get('/getClientAllProject/{client}',[App\Http\Controllers\GetApNameController::class,'getClientAllProject']);
Route::get('/getManagerProjectInventory',[App\Http\Controllers\GetApNameController::class,'getManagerProjectInventory']);
Route::get('/getManagerAll',[App\Http\Controllers\GetApNameController::class,'getManagerAll']);
Route::delete('/manager_delete/{id}',[App\Http\Controllers\GetApNameController::class,'manager_delete']);
Route::get('/check_admin_current_password/{password}',[App\Http\Controllers\GetApNameController::class,'check_admin_current_password']);
Route::get('/check_manager_current_password/{password}',[App\Http\Controllers\GetApNameController::class,'check_manager_current_password']);
Route::post('/update_admin_current_password',[App\Http\Controllers\GetApNameController::class,'update_admin_current_password']);
Route::post('/update_manager_current_password',[App\Http\Controllers\GetApNameController::class,'update_manager_current_password']);
Route::get('/getClientProject/{project}',[App\Http\Controllers\GetApNameController::class,'getClientProject']);

Route::get('/getReceiptvouchers/{project}',[App\Http\Controllers\GetApNameController::class,'getReceiptvouchers']);
Route::get('/getPaymentvouchers/{project}',[App\Http\Controllers\GetApNameController::class,'getPaymentvouchers']);

Route::get('/getManagerPayable/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerPayable']);

Route::get('/getManagerPayableAll/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerPayableAll']);

Route::get('/getManagerReceiptPayable/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerReceiptPayable']);
Route::get('/getManagerReceivableAll/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerReceivableAll']);

//notification
Route::apiResource('/notification',App\Http\Controllers\notificationController::class);

Route::get('/reset_notification',[App\Http\Controllers\GetApNameController::class,'reset_notification']);

//accounts access

Route::apiResource('/accounts_access',App\Http\Controllers\AccountsAccessController::class);
Route::get('/fetch_access/{manager}',[App\Http\Controllers\GetApNameController::class,'fetch_access']);


Route::get('/manager_fetch_employee/{project}',[App\Http\Controllers\GetApNameController::class,'manager_fetch_employee']);

Route::get('/manager_fetch_expense/{project}',[App\Http\Controllers\GetApNameController::class,'manager_fetch_expense']);

//fetch client id base on voucher
Route::get('/fetch_client',[App\Http\Controllers\GetApNameController::class,'fetch_client']);
Route::get('/fetch_client_by_project/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_client_by_project']);

Route::get('/fetch_client_accounts/{client_id}',[App\Http\Controllers\GetApNameController::class,'fetch_client_accounts']);

Route::get('/getManagerProjectClientList/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerProjectClientList']);
Route::get('/fetch_project/{project}',[App\Http\Controllers\GetApNameController::class,'project']);

Route::get('/fetch_access_manager',[App\Http\Controllers\GetApNameController::class,'fetch_access_manager']);
Route::get('/unit/getUnitItem/{product}',[App\Http\Controllers\GetApNameController::class,'getUnitItem']);

Route::get('/getSingleProjectClient/{project}',[App\Http\Controllers\GetApNameController::class,'getSingleProjectClient']);

Route::get('/fetchSingleProjectClient',[App\Http\Controllers\GetApNameController::class,'fetchSingleProjectClient']);

Route::delete('/delete_accounts_access/{id}',[App\Http\Controllers\GetApNameController::class,'delete_accounts_access']);
Route::get('/fetchFilterProject',[App\Http\Controllers\GetApNameController::class,'fetchFilterProject']);

Route::get('/fetchSelectedProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchSelectedProject']);
Route::get('/fetchSelectedBuilding/{building}',[App\Http\Controllers\GetApNameController::class,'fetchSelectedBuilding']);
Route::get('/fetchBuildingFromProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingFromProject']);
Route::get('/fethProjectPurchase',[App\Http\Controllers\GetApNameController::class,'fethProjectPurchase']);
Route::get('/fetchSingleProjectPurchase/{project}',[App\Http\Controllers\GetApNameController::class,'fetchSingleProjectPurchase']);

Route::get('/fetchProjectsJournal',[App\Http\Controllers\GetApNameController::class,'fetchProjectsJournal']);
Route::get('/fetchPurchasedJournal/{project}',[App\Http\Controllers\GetApNameController::class,'fetchPurchasedJournal']);

Route::get('/fetchProjectsPayableJournal',[App\Http\Controllers\GetApNameController::class,'fetchProjectsPayableJournal']);

Route::get('/fetchPayableJournalProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchPayableJournalProject']);

Route::get('/fetchProjectsReceivableJournal',[App\Http\Controllers\GetApNameController::class,'fetchProjectsReceivableJournal']);
Route::get('/fetchProjectsReceivableJournalSelect/{project}',[App\Http\Controllers\GetApNameController::class,'fetchProjectsReceivableJournalSelect']);

Route::get('/fetchProjectsReceiptJournal',[App\Http\Controllers\GetApNameController::class,'fetchProjectsReceiptJournal']);

Route::get('/fetchProjectsReceiptJournalSelect/{project}',[App\Http\Controllers\GetApNameController::class,'fetchProjectsReceiptJournalSelect']);
Route::get('/fetchAdminExpense',[App\Http\Controllers\GetApNameController::class,'fetchAdminExpense']);
Route::get('/expensebuilding/{building}',[App\Http\Controllers\GetApNameController::class,'expensebuilding']);

Route::get('/fetchAdminExpenseByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchAdminExpenseByProject']);
Route::get('/fetchBuildingByProjects/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingByProjects']);

Route::get('/fetchBuildingFromProjectExpense/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingFromProjectExpense']);
Route::get('/fetchAdminEmployee',[App\Http\Controllers\GetApNameController::class,'fetchAdminEmployee']);

Route::get('/fetchAdminEmployeeByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchAdminEmployeeByProject']);
Route::get('/fetchBuildingEmployee/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingEmployee']);
Route::get('/fetchemployeeallbuildings/{project}',[App\Http\Controllers\GetApNameController::class,'fetchemployeeallbuildings']);
Route::get('/fetchsinglebuildingemployee/{building}',[App\Http\Controllers\GetApNameController::class,'fetchsinglebuildingemployee']);
Route::get('/fetchByBuildingClient/{building}',[App\Http\Controllers\GetApNameController::class,'fetchByBuildingClient']);
Route::get('/fetchInventoryProject',[App\Http\Controllers\GetApNameController::class,'fetchInventoryProject']);
Route::get('/fetchBuildingInventory/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInventory']);
Route::get('/fetchDataByBuilding/{building}',[App\Http\Controllers\GetApNameController::class,'fetchDataByBuilding']);
Route::get('/fetchDataByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchDataByProject']);
Route::get('/fetch_supplier_history',[App\Http\Controllers\GetApNameController::class,'fetch_supplier_history']);
Route::get('/getManagerPaymentHistory/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerPaymentHistory']);
Route::get('/payment_history_view/{id}',[App\Http\Controllers\GetApNameController::class,'payment_history_view']);
Route::get('/payment_history_edit/{id}',[App\Http\Controllers\GetApNameController::class,'payment_history_edit']);

Route::apiResource('/history',App\Http\Controllers\PaymentHistoryController::class);
Route::delete('/delete_history/{id}',[App\Http\Controllers\GetApNameController::class,'delete_history']);
Route::get('/fetch_client_history',[App\Http\Controllers\GetApNameController::class,'fetch_client_history']);
Route::get('/getManagerReceiptHistory/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerReceiptHistory']);
Route::get('/receipt_history_view/{id}',[App\Http\Controllers\GetApNameController::class,'receipt_history_view']);
Route::post('/history_receipt',[App\Http\Controllers\GetApNameController::class,'history_receipt']);
Route::delete('/delete_receipt/{id}',[App\Http\Controllers\GetApNameController::class,'delete_receipt']);
Route::get('/fetchBuildingFromProjectInventories/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingFromProjectInventories']);
Route::apiResource('/advance_pay',App\Http\Controllers\AdvancePayController::class);
Route::get('/deleteFromTotal/{id}',[App\Http\Controllers\GetApNameController::class,'deleteFromTotal']);
Route::get('/getAdvanceById/{id}',[App\Http\Controllers\GetApNameController::class,'getAdvanceById']);
Route::get('/projectFromAdvancePay',[App\Http\Controllers\GetApNameController::class,'projectFromAdvancePay']);
Route::get('/advancePaysSelectedProject/{project}',[App\Http\Controllers\GetApNameController::class,'advancePaysSelectedProject']);
Route::get('/advancePaysFetchAllBuildings/{project}',[App\Http\Controllers\GetApNameController::class,'advancePaysFetchAllBuildings']);
Route::get('/advancePaysFetchByBuildings/{building}',[App\Http\Controllers\GetApNameController::class,'advancePaysFetchByBuildings']);
Route::post('/fetchAdvanceByDate',[App\Http\Controllers\GetApNameController::class,'fetchAdvanceByDate']);


Route::post('/fetchAdvanceInVoucher',[App\Http\Controllers\GetApNameController::class,'fetchAdvanceInVoucher']);
Route::post('/updatedAdvance',[App\Http\Controllers\GetApNameController::class,'updatedAdvance']);
Route::post('/deleteInAdvance',[App\Http\Controllers\GetApNameController::class,'deleteInAdvance']);

Route::get('/fetchClientByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchClientByProject']);

//construction
Route::apiResource('/construction',App\Http\Controllers\ConstructionRequiredController::class);
Route::get('/constructionOne/{project}',[App\Http\Controllers\ConstructionRequiredController::class,'constructionOne']);
Route::get('/constructionAll/{project}',[App\Http\Controllers\ConstructionRequiredController::class,'constructionAll']);
Route::get('/getMergeGroup/{project}',[App\Http\Controllers\GetApNameController::class,'getMergeGroup']);
Route::get('/projectFromConstruction',[App\Http\Controllers\GetApNameController::class,'projectFromConstruction']);
Route::get('/constructionSelectedProject/{project}',[App\Http\Controllers\GetApNameController::class,'constructionSelectedProject']);
Route::get('/constructionSelectedBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'constructionSelectedBuilding']);
Route::get('/constructionSelectedProject1/{project}',[App\Http\Controllers\GetApNameController::class,'constructionSelectedProject1']);
Route::get('/constructionFetchByBuildings1/{project}',[App\Http\Controllers\GetApNameController::class,'constructionFetchByBuildings1']);

Route::get('/constructionFetchByBuildings/{building}',[App\Http\Controllers\GetApNameController::class,'constructionFetchByBuildings']);
Route::post('/fetchConstructionByDate',[App\Http\Controllers\GetApNameController::class,'fetchConstructionByDate']);
Route::apiResource('/pay_construction',App\Http\Controllers\ConstructionPayController::class);
Route::get('/constructionSelectedProjectPay/{project}',[App\Http\Controllers\GetApNameController::class,'constructionSelectedProjectPay']);
Route::get('/constructionSelectedBuildingPay/{project}',[App\Http\Controllers\GetApNameController::class,'constructionSelectedBuildingPay']);
Route::post('/fetchPayConstructionByDate',[App\Http\Controllers\GetApNameController::class,'fetchPayConstructionByDate']);
Route::get('/constructionFetchByBuildingsPay/{building}',[App\Http\Controllers\GetApNameController::class,'constructionFetchByBuildingsPay']);
Route::post('/fetch_paid_construction',[App\Http\Controllers\GetApNameController::class,'fetch_paid_construction']);



Route::get('/gettListByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'gettListByBuilding']);
Route::get('/fetch_all_buildling',[App\Http\Controllers\GetApNameController::class,'fetch_all_buildling']);
Route::get('/fetch_client_by_project_in_building/{building}',[App\Http\Controllers\GetApNameController::class,'fetch_client_by_project_in_building']);
Route::get('/fetch_client_accounts_in_building/{id}',[App\Http\Controllers\GetApNameController::class,'fetch_client_accounts_in_building']);
Route::get('/construction_project_list',[App\Http\Controllers\GetApNameController::class,'construction_project_list']);
Route::get('/getManagerProjectClientListConstruction/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerProjectClientListConstruction']);
Route::get('/fetch_construction_by_project/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_construction_by_project']);
Route::get('/fetch_construction_project_accounts/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_construction_project_accounts']);
Route::get('/construction_building_list',[App\Http\Controllers\GetApNameController::class,'construction_building_list']);
Route::get('/getManagerBuildingListConstruction/{project}',[App\Http\Controllers\GetApNameController::class,'getManagerBuildingListConstruction']);
Route::get('/fetch_construction_project_accounts_building/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_construction_project_accounts_building']);
Route::post('/fetchReceiptVoucherByDate',[App\Http\Controllers\GetApNameController::class,'fetchReceiptVoucherByDate']);
Route::post('/fetchPaymentVoucherByDate',[App\Http\Controllers\GetApNameController::class,'fetchPaymentVoucherByDate']);
Route::post('/fetchAllExpenseByDate',[App\Http\Controllers\GetApNameController::class,'fetchAllExpenseByDate']);
Route::post('/fetchAllEmployeeByDate',[App\Http\Controllers\GetApNameController::class,'fetchAllEmployeeByDate']);
Route::get('/fetchBuildingFromProjectInPayment/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingFromProjectInPayment']);
Route::get('/fetchBuildingFromPayment/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingFromPayment']);

Route::get('/getPurchaseByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'getPurchaseByBuilding']);
Route::get('/getProductByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'getProductByBuilding']);
Route::get('/getProductByProject/{project}',[App\Http\Controllers\GetApNameController::class,'getProductByProject']);
Route::get('/getDataByProduct/{project}',[App\Http\Controllers\GetApNameController::class,'getDataByProduct']);
Route::get('/fetchBuildlingsInPurchaseJournal/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildlingsInPurchaseJournal']);
Route::get('/fetchByBuildlingsInPurchaseJournal/{project}',[App\Http\Controllers\GetApNameController::class,'fetchByBuildlingsInPurchaseJournal']);
Route::get('/getBuildingInPayable/{project}',[App\Http\Controllers\GetApNameController::class,'getBuildingInPayable']);

Route::get('/getPayableByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'getPayableByBuilding']);
Route::get('/fetchBuildingInReceivable/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInReceivable']);
Route::get('/fetchReceivableByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'fetchReceivableByBuilding']);
Route::get('/fetchBuildingInReceiptJournal/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInReceiptJournal']);
Route::get('/fetchReceiptJournalByBuildingName/{project}',[App\Http\Controllers\GetApNameController::class,'fetchReceiptJournalByBuildingName']);
Route::get('/fetchBuildingByProjectInStock/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingByProjectInStock']);
Route::get('/fetchAllProjectFromStock',[App\Http\Controllers\GetApNameController::class,'fetchAllProjectFromStock']);
Route::get('/fetchStockByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchStockByProject']);
Route::get('/fetchBuildingInStock/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInStock']);
Route::get('/fetchStockByBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'fetchStockByBuilding']);
Route::get('/clientBaseSearchAdvanceManager/{client}',[App\Http\Controllers\GetApNameController::class,'clientBaseSearchAdvanceManager']);
Route::post('/clientBaseSearchRequiredConstructionManager',[App\Http\Controllers\GetApNameController::class,'clientBaseSearchRequiredConstructionManager']);

Route::post('/clientBaseSearchAdvance',[App\Http\Controllers\GetApNameController::class,'clientBaseSearchAdvance']);
Route::post('/clientBaseSearchRequiredConstruction',[App\Http\Controllers\GetApNameController::class,'clientBaseSearchRequiredConstruction']);
Route::post('/clientBaseSearcPayConstruction',[App\Http\Controllers\GetApNameController::class,'clientBaseSearcPayConstruction']);
Route::get('/clientBaseSearcPayConstructionManager/{client}',[App\Http\Controllers\GetApNameController::class,'clientBaseSearcPayConstructionManager']);
Route::post('/productBaseSearchExpense',[App\Http\Controllers\GetApNameController::class,'productBaseSearchExpense']);
Route::post('/productBaseSearchExpenseManager',[App\Http\Controllers\GetApNameController::class,'productBaseSearchExpenseManager']);
Route::post('/employeeBaseSearchExpense',[App\Http\Controllers\GetApNameController::class,'employeeBaseSearchExpense']);
Route::get('/employeeBaseSearchExpenseManager/{employee}',[App\Http\Controllers\GetApNameController::class,'employeeBaseSearchExpenseManager']);
Route::post('/receiptBaseSearchExpense',[App\Http\Controllers\GetApNameController::class,'receiptBaseSearchExpense']);
Route::get('/receiptBaseSearchExpenseManager/{receipt}',[App\Http\Controllers\GetApNameController::class,'receiptBaseSearchExpenseManager']);
Route::post('/paymentBaseSearchExpense',[App\Http\Controllers\GetApNameController::class,'paymentBaseSearchExpense']);
Route::post('/paymentBaseSearchExpenseManager',[App\Http\Controllers\GetApNameController::class,'paymentBaseSearchExpenseManager']);
Route::post('/paymentBaseSearchExpenseLedger',[App\Http\Controllers\GetApNameController::class,'paymentBaseSearchExpenseLedger']);
Route::post('/paymentBaseSearchExpenseManagerLedger',[App\Http\Controllers\GetApNameController::class,'paymentBaseSearchExpenseManagerLedger']);
Route::get('/mergeConstruction',[App\Http\Controllers\ConstructionRequiredController::class,'mergeConstruction']);

Route::delete('/delete_merge_construction/{id}',[App\Http\Controllers\GetApNameController::class,'delete_merge_construction']);
Route::get('/view_merge_construction/{id}',[App\Http\Controllers\GetApNameController::class,'view_merge_construction']);
Route::post('/fetchStockJournalByDate',[App\Http\Controllers\GetApNameController::class,'fetchStockJournalByDate']);
Route::post('/fetchStockJournalByDateProduct',[App\Http\Controllers\GetApNameController::class,'fetchStockJournalByDateProduct']);
Route::post('/pay_construction_merge',[App\Http\Controllers\GetApNameController::class,'pay_construction_merge']);
Route::get('/manager_fetch_salary/{project}',[App\Http\Controllers\GetApNameController::class,'manager_fetch_salary']);

Route::patch('/edit_merge_construction/{id}',[App\Http\Controllers\GetApNameController::class,'edit_merge_construction']);
Route::get('/fetchAdminEmployeeByProjectSalary/{project}',[App\Http\Controllers\GetApNameController::class,'fetchAdminEmployeeByProjectSalary']);
Route::get('/fetchemployeeallbuildingsSalary/{project}',[App\Http\Controllers\GetApNameController::class,'fetchemployeeallbuildingsSalary']);

Route::get('/calculateWeeklyPurchase',[App\Http\Controllers\GetApNameController::class,'calculateWeeklyPurchase']);
Route::get('/calculateWeeklySalesAmount',[App\Http\Controllers\GetApNameController::class,'calculateWeeklySalesAmount']);
Route::get('/calculateWeeklyPaymentDue',[App\Http\Controllers\GetApNameController::class,'calculateWeeklyPaymentDue']);
Route::get('/calculateWeeklyReceiptDue',[App\Http\Controllers\GetApNameController::class,'calculateWeeklyReceiptDue']);
Route::get('/calculateWeeklyGetExpense',[App\Http\Controllers\GetApNameController::class,'calculateWeeklyGetExpense']);
Route::get('/calculateWeeklyGetSalary',[App\Http\Controllers\GetApNameController::class,'calculateWeeklyGetSalary']);


//daily
Route::get('/calculateDailyPurchase',[App\Http\Controllers\GetApNameController::class,'calculateDailyPurchase']);
Route::get('/calculateDailySalesAmount',[App\Http\Controllers\GetApNameController::class,'calculateDailySalesAmount']);
Route::get('/calculateDailyPaymentDue',[App\Http\Controllers\GetApNameController::class,'calculateDailyPaymentDue']);
Route::get('/calculateDailyReceiptDue',[App\Http\Controllers\GetApNameController::class,'calculateDailyReceiptDue']);
Route::get('/calculateDailyGetExpense',[App\Http\Controllers\GetApNameController::class,'calculateDailyGetExpense']);
Route::get('/calculateDailyGetSalary',[App\Http\Controllers\GetApNameController::class,'calculateDailyGetSalary']);


//monthly
Route::get('/calculateMonthlyPurchase',[App\Http\Controllers\GetApNameController::class,'calculateMonthlyPurchase']);
Route::get('/calculateMonthlySalesAmount',[App\Http\Controllers\GetApNameController::class,'calculateMonthlySalesAmount']);
Route::get('/calculateMonthlyPaymentDue',[App\Http\Controllers\GetApNameController::class,'calculateMonthlyPaymentDue']);
Route::get('/calculateMonthlyReceiptDue',[App\Http\Controllers\GetApNameController::class,'calculateMonthlyReceiptDue']);
Route::get('/calculateMonthlyGetExpense',[App\Http\Controllers\GetApNameController::class,'calculateMonthlyGetExpense']);
Route::get('/calculateMonthlyGetSalary',[App\Http\Controllers\GetApNameController::class,'calculateMonthlyGetSalary']);

//yearly

Route::get('/calculateYearlyPurchase',[App\Http\Controllers\GetApNameController::class,'calculateYearlyPurchase']);
Route::get('/calculateYearlySalesAmount',[App\Http\Controllers\GetApNameController::class,'calculateYearlySalesAmount']);
Route::get('/calculateYearlyPaymentDue',[App\Http\Controllers\GetApNameController::class,'calculateYearlyPaymentDue']);
Route::get('/calculateYearlyReceiptDue',[App\Http\Controllers\GetApNameController::class,'calculateYearlyReceiptDue']);
Route::get('/calculateYearlyGetExpense',[App\Http\Controllers\GetApNameController::class,'calculateYearlyGetExpense']);
Route::get('/calculateYearlyGetSalary',[App\Http\Controllers\GetApNameController::class,'calculateYearlyGetSalary']);
//date
Route::post('/calculateDatePurchase',[App\Http\Controllers\GetApNameController::class,'calculateDatePurchase']);
Route::post('/calculateDateSalesAmount',[App\Http\Controllers\GetApNameController::class,'calculateDateSalesAmount']);
Route::post('/calculateDatePaymentDue',[App\Http\Controllers\GetApNameController::class,'calculateDatePaymentDue']);
Route::post('/calculateDateReceiptDue',[App\Http\Controllers\GetApNameController::class,'calculateDateReceiptDue']);
Route::post('/calculateDateGetExpense',[App\Http\Controllers\GetApNameController::class,'calculateDateGetExpense']);
Route::post('/calculateDateGetSalary',[App\Http\Controllers\GetApNameController::class,'calculateDateGetSalary']);
//byproject
Route::get('/calculateProjectPurchase/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectPurchase']);
Route::get('/calculateProjectSalesAmount/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectSalesAmount']);
Route::get('/calculateProjectPaymentDue/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectPaymentDue']);
Route::get('/calculateProjectReceiptDue/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectReceiptDue']);
Route::get('/calculateProjectGetExpense/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectGetExpense']);
Route::get('/calculateProjectGetSalary/{project}',[App\Http\Controllers\GetApNameController::class,'calculateProjectGetSalary']);
//building
Route::get('/calculateBuildingPurchase/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingPurchase']);
Route::get('/calculateBuildingSalesAmount/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingSalesAmount']);
Route::get('/calculateBuildingPaymentDue/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingPaymentDue']);
Route::get('/calculateBuildingReceiptDue/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingReceiptDue']);
Route::get('/calculateBuildingGetExpense/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingGetExpense']);
Route::get('/calculateBuildingGetSalary/{project}',[App\Http\Controllers\GetApNameController::class,'calculateBuildingGetSalary']);

//manager
Route::get('/fethProjectPurchaseManager/{name}',[App\Http\Controllers\GetApNameController::class,'fethProjectPurchaseManager']);
//
Route::get('/getExpense',[App\Http\Controllers\GetApNameController::class,'getExpense']);
Route::get('/getSalary',[App\Http\Controllers\GetApNameController::class,'getSalary']);
//

Route::get('/fetchDashboardProject',[App\Http\Controllers\GetApNameController::class,'fetchDashboardProject']);
Route::get('/fetchBuildingByProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingByProject']);

//
Route::get('/totalClient',[App\Http\Controllers\GetApNameController::class,'totalClient']);
Route::get('/totalSupplier',[App\Http\Controllers\GetApNameController::class,'totalSupplier']);
Route::get('/totalEmployee',[App\Http\Controllers\GetApNameController::class,'totalEmployee']);
//daily
Route::get('/totalDailyClient',[App\Http\Controllers\GetApNameController::class,'totalDailyClient']);
Route::get('/totalDailySupplier',[App\Http\Controllers\GetApNameController::class,'totalDailySupplier']);
Route::get('/totalDailyEmployee',[App\Http\Controllers\GetApNameController::class,'totalDailyEmployee']);
//weekly
Route::get('/totalWeeklyClient',[App\Http\Controllers\GetApNameController::class,'totalWeeklyClient']);
Route::get('/totalWeeklySupplier',[App\Http\Controllers\GetApNameController::class,'totalWeeklySupplier']);
Route::get('/totalWeeklyEmployee',[App\Http\Controllers\GetApNameController::class,'totalWeeklyEmployee']);
//monthly
Route::get('/totalMonthlyClient',[App\Http\Controllers\GetApNameController::class,'totalMonthlyClient']);
Route::get('/totalMonthlySupplier',[App\Http\Controllers\GetApNameController::class,'totalMonthlySupplier']);
Route::get('/totalMonthlyEmployee',[App\Http\Controllers\GetApNameController::class,'totalMonthlyEmployee']);

//yearly
Route::get('/totalYearlyClient',[App\Http\Controllers\GetApNameController::class,'totalYearlyClient']);
Route::get('/totalYearlySupplier',[App\Http\Controllers\GetApNameController::class,'totalYearlySupplier']);
Route::get('/totalYearlyEmployee',[App\Http\Controllers\GetApNameController::class,'totalYearlyEmployee']);
//date range
Route::post('/totalDateClient',[App\Http\Controllers\GetApNameController::class,'totalDateClient']);
Route::post('/totalDateSupplier',[App\Http\Controllers\GetApNameController::class,'totalDateSupplier']);
Route::post('/totalDateEmployee',[App\Http\Controllers\GetApNameController::class,'totalDateEmployee']);
//project
Route::get('/totalProjectClient/{project}',[App\Http\Controllers\GetApNameController::class,'totalProjectClient']);
Route::get('/totalProjectEmployee/{project}',[App\Http\Controllers\GetApNameController::class,'totalProjectEmployee']);
Route::get('/totalProjectSupplier/{project}',[App\Http\Controllers\GetApNameController::class,'totalProjectSupplier']);

//building
Route::get('/totalBuildingClient/{building}',[App\Http\Controllers\GetApNameController::class,'totalBuildingClient']);
Route::get('/totalBuildingEmployee/{building}',[App\Http\Controllers\GetApNameController::class,'totalBuildingEmployee']);
Route::get('/totalBuildingSupplier/{building}',[App\Http\Controllers\GetApNameController::class,'totalBuildingSupplier']);

//


Route::get('/fetchAdminStock',[App\Http\Controllers\GetApNameController::class,'fetchAdminStock']);
Route::get('/fetchManagerProject/{name}',[App\Http\Controllers\GetApNameController::class,'fetchManagerProject']);

Route::get('/fetchManagerStock/{project}',[App\Http\Controllers\GetApNameController::class,'fetchManagerStock']);
Route::get('/fetchSelectedStockProject/{project}',[App\Http\Controllers\GetApNameController::class,'fetchSelectedStockProject']);
Route::get('/fetchSelectedStockProjectBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'fetchSelectedStockProjectBuilding']);
Route::get('/fetchStockProjectBuilding/{project}',[App\Http\Controllers\GetApNameController::class,'fetchStockProjectBuilding']);
Route::post('/stockBaseDate',[App\Http\Controllers\GetApNameController::class,'stockBaseDate']);
Route::post('/stockBaseDateAll',[App\Http\Controllers\GetApNameController::class,'stockBaseDateAll']);
Route::post('/purchase_land_details_update',[App\Http\Controllers\GetApNameController::class,'purchase_land_details_update']);
Route::apiResource('/stock_transfer',App\Http\Controllers\StockTransferController::class);

Route::get('/fetchStockByProjectTransfer/{project}',[App\Http\Controllers\GetApNameController::class,'fetchStockByProjectTransfer']);
Route::get('/fetchBuildingInStockTransfer/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInStockTransfer']);
Route::get('/fetchStockByBuildingTransfered/{building}',[App\Http\Controllers\GetApNameController::class,'fetchStockByBuildingTransfered']);
Route::get('/fetchStockByProjectTransferTo/{project}',[App\Http\Controllers\GetApNameController::class,'fetchStockByProjectTransferTo']);
Route::get('/fetchBuildingInStockTransferTo/{project}',[App\Http\Controllers\GetApNameController::class,'fetchBuildingInStockTransferTo']);
Route::get('/fetchStockByBuildingTransferedTo/{building}',[App\Http\Controllers\GetApNameController::class,'fetchStockByBuildingTransferedTo']);
Route::post('/fetchStockJournalByDateTransfer',[App\Http\Controllers\GetApNameController::class,'fetchStockJournalByDateTransfer']);
Route::post('/fetchStockJournalByDateProductTransfer',[App\Http\Controllers\GetApNameController::class,'fetchStockJournalByDateProductTransfer']);
Route::post('/getTransferedQuantity',[App\Http\Controllers\GetApNameController::class,'getTransferedQuantity']);
Route::post('/stock_transfer_update',[App\Http\Controllers\StockTransferController::class,'stock_transfer_update']);
Route::get('/pay_construction_voucher/{id}',[App\Http\Controllers\GetApNameController::class,'pay_construction_voucher']);

Route::get('/fetchProjectCode/{id}',[App\Http\Controllers\GetApNameController::class,'fetchProjectCode']);

Route::post('/construction_pays_update',[App\Http\Controllers\ConstructionPayController::class,'construction_pays_update']);

Route::get('/idMaker/{building}',[App\Http\Controllers\GetApNameController::class,'idMaker']);
//Building
Route::apiResource('/building',BuildingController::class);
Route::post('/building/postBuilding',[BuildingController::class,'postBuilding']);
//get building 
// 
Route::get('/getBuildingByPropertyProject/{project}',[App\Http\Controllers\GetApNameController::class,'getBuildingByPropertyProject']);
Route::post('/inventory/building',[App\Http\Controllers\InventoryController::class,'building']);
Route::get('/fetch_sales_project',[App\Http\Controllers\GetApNameController::class,'fetch_sales_project']);
Route::get('/fetch_sales_project_manager/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_sales_project_manager']);
Route::get('/fetch_sales_project_report/{project}',[App\Http\Controllers\InventoryController::class,'fetch_sales_project_report']);
Route::get('/fetch_sales_building/{project}',[App\Http\Controllers\GetApNameController::class,'fetch_sales_building']);
Route::get('/fetch_sales_project_report_floor/{building}',[App\Http\Controllers\InventoryController::class,'fetch_sales_project_report_floor']);
Route::get('/fetch_sales_project_report_floor_name/{building}',[App\Http\Controllers\InventoryController::class,'fetch_sales_project_report_floor_name']);
Route::get('/sales/sales_project',[App\Http\Controllers\InventoryController::class,'sales_project']);
Route::post('/sales/modifySales',[App\Http\Controllers\InventoryController::class,'modifySales']);
Route::post('/sales/addSales',[App\Http\Controllers\InventoryController::class,'addSales']);
Route::post('/sales/lessSales',[App\Http\Controllers\InventoryController::class,'lessSales']);
Route::get('/sales/fetchAllProject',[App\Http\Controllers\InventoryController::class,'fetchAllProject']);

Route::get('/sales_fetch_project/{project}',[App\Http\Controllers\InventoryController::class,'sales_fetch_project']);
Route::get('/sales_fetch_building/{project}',[App\Http\Controllers\InventoryController::class,'sales_fetch_building']);
Route::get('/sales_fetch_project_building/{building}',[App\Http\Controllers\InventoryController::class,'sales_fetch_project_building']);
Route::get('/fetch_property/{building}',[App\Http\Controllers\InventoryController::class,'fetch_property']);
Route::get('/sales_fetch_flat_name/{building}',[App\Http\Controllers\InventoryController::class,'sales_fetch_flat_name']);
Route::get('/get_building_data/{id}',[App\Http\Controllers\GetApNameController::class,'get_building_data']);

//view_client_select_property
Route::get('/get_client_project/{id}',[App\Http\Controllers\GetApNameController::class,'get_client_project']);
Route::get('/get_client_project_building/{property}',[App\Http\Controllers\GetApNameController::class,'get_client_project_building']);
Route::get('/fetch_client_property_name/{id}',[App\Http\Controllers\GetApNameController::class,'fetch_client_property_name']);
Route::patch('/fill_voucher_by_property/{id}',[App\Http\Controllers\GetApNameController::class,'fill_voucher_by_property']);
Route::delete('/deleteUnit/{id}',[App\Http\Controllers\GetApNameController::class,'deleteUnit']);
//Category
Route::apiResource('/category',CategoryController::class);
//Fine
Route::apiResource('/fine',FineController::class);
//Check Sold
Route::get('/checkSold/{id}',[App\Http\Controllers\GetApNameController::class,'checkSold']);
//show client by building
Route::get('/showClientByBuilding/{building}',[App\Http\Controllers\GetApNameController::class,'showClientByBuilding']);
//fetch client construction
Route::get('/fetch_client_construction/{id}',[GetApNameController::class,'fetch_client_construction']);
Route::get('/construction_merge/{id}',[GetApNameController::class,'construction_merge']);