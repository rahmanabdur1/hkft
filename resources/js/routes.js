import { createWebHistory, createRouter } from "vue-router";

import home from './home.vue';
import register_admin from './dashboard/admin/auth/register_admin.vue';
import login_admin from './dashboard/admin/auth/login_admin.vue';

import register_manager from './dashboard/manager/auth/register_manager.vue';
import login_manager from './dashboard/manager/auth/login_manager.vue';


import admin_dashboard from './dashboard/admin/admin_dashboard.vue';
import manager_dashboard from './dashboard/manager/manager_dashboard.vue';
//pages
//late fine
import late_fine from './pages/Late Fine/late_fine.vue';
//project
import add_project from './pages/project/add_project.vue';
import all_project from './pages/project/all_project.vue';
import edit_project from './pages/project/edit_project.vue';
import view_project from './pages/project/view_project.vue';
import add_stage from './pages/project_stage/add_stage.vue';
import edit_stage from './pages/project_stage/edit_stage.vue';

//building
import create_building from './pages/Building/create_building.vue';
import index_building from "./pages/Building/index_building.vue";
import edit_building from "./pages/Building/edit_building.vue";
import view_building from "./pages/Building/view_building.vue";
//client
import add_client from './pages/client/add_client.vue';
import all_client from './pages/client/all_client.vue';
import edit_client from './pages/client/edit_client.vue';
import view_client from './pages/client/view_client.vue';
import tin_client from './pages/client/tin_client.vue';
import nid_client from './pages/client/nid_client.vue';
import passport_client from './pages/client/passport_client.vue';
// Supplier
import add_supplier from './pages/supplier/add_supplier.vue';
import all_supplier from './pages/supplier/all_supplier.vue';
import edit_supplier from './pages/supplier/edit_supplier.vue';

//accounts
import account_type from './pages/accounts/account_type.vue';
import add_account_type from './pages/accounts/add_account_type.vue';
import edit_account_type from './pages/accounts/edit_account_type.vue';

import account_head from './pages/account_head/account_head.vue';
import add_account_head from './pages/account_head/add_account_head.vue';
import edit_account_head from './pages/account_head/edit_account_head.vue';

//receipt voucher
import receipt_voucher from './pages/receipt_voucher/receipt_voucher.vue';
import all_voucher from './pages/receipt_voucher/all_voucher.vue';
import view_voucher from './pages/receipt_voucher/view_voucher.vue';
import edit_voucher from './pages/receipt_voucher/edit_voucher.vue';
import print_voucher from './pages/receipt_voucher/print_voucher.vue';
import receipt_document from './pages/receipt_voucher/receipt_document.vue';

//payment voucher
import payment_voucher from './pages/payment_voucher/payment_voucher.vue';
import payment_all_voucher from './pages/payment_voucher/all_voucher.vue';
import payment_view_voucher from './pages/payment_voucher/view_voucher.vue';
import payment_edit_voucher from './pages/payment_voucher/edit_voucher.vue';
import payment_print_voucher from './pages/payment_voucher/print_voucher.vue';

//unit
import unit from './pages/unit/unit.vue';
import all_unit from './pages/unit/all_unit.vue';
import edit_unit from './pages/unit/edit_unit.vue';

//journal
import accounts_payable from './pages/journal/accounts_payable.vue';
import accounts_receivable from './pages/journal/accounts_receivable.vue';
import purchase_journal from './pages/journal/purchase_journal.vue';
import sales_journal from './pages/journal/receipt_journal.vue';

//ledger
import ledger from './pages/ledger/ledger.vue';
import purchase_ledger from './pages/ledger/purchase_ledger.vue';
import apledger from './pages/ledger/apledger.vue';
import cash_ledger from './pages/ledger/cash_ledger.vue';
import bank_ledger from './pages/ledger/bank_ledger.vue';
import sales_ledger from './pages/ledger/sales_ledger.vue';
import rpledger from './pages/ledger/rpledger.vue';
//pay payable
import all_pay_payable from './pages/return_pay/all_pay_payable.vue';
import edit_pay_payable from './pages/return_pay/edit_pay_payable.vue';
import pay_payable from './pages/return_pay/pay_payable.vue';
//payment history
import payment_history from './pages/history/payment_history.vue';
import edit_payment_history from './pages/history/edit_payment_history.vue';
import view_payment_history from './pages/history/view_payment_history.vue';
import update_payment_history from './pages/history/update_payment_history.vue';

//pay receivable
import pay_receivable from './pages/return_pay/pay_receivable.vue';
import edit_pay_receivable from './pages/return_pay/edit_pay_receivable.vue';
import all_pay_receivable from './pages/return_pay/all_pay_receivable.vue';
//category
import all_category from './pages/category/all_category.vue';

//receipt history
import receipt_history from './pages/history/receipt_history.vue';
import edit_receipt_history from './pages/history/edit_receipt_history.vue';
import view_receipt_history from './pages/history/view_receipt_history.vue';
import update_receipt_history from './pages/history/update_receipt_history.vue';

//purchase_return
import all_purchase_return from './pages/return_pay/all_purchase_return.vue';
import edit_purchase_return from './pages/return_pay/edit_purchase_return.vue';
import purchase_return from './pages/return_pay/purchase_return.vue';

//sales
import all_sales from './pages/Sales/all_sales.vue';
import create_sales from './pages/Sales/create_sales.vue';
import create_sales_building from './pages/Sales/create_sales_building.vue';

import edit_sales from './pages/Sales/edit_sales.vue';
import view_sales from './pages/Sales/view_sales.vue';
import sales_project from './pages/Sales/sales_project.vue';
import sales_building from './pages/Sales/sales_building.vue';

//purchase land details
import all_purchase_land from './pages/purchase_land/all_purchase_land.vue';
import add_purchase_land from './pages/purchase_land/add_purchase_land.vue';
import edit_purchase_land from './pages/purchase_land/edit_purchase_land.vue';
import view_purchase_land from './pages/purchase_land/view_purchase_land.vue';

//expense
import add_expense from './pages/Expense/add_expense.vue';
import all_expense from './pages/Expense/all_expense.vue';
import edit_expense from './pages/Expense/edit_expense.vue';
import view_expense  from './pages/Expense/view_expense.vue';

//salary
import add_employee from './pages/salary/add_employee.vue';
import all_employee from './pages/salary/all_employee.vue';
import edit_employee from './pages/salary/edit_employee.vue';
import pay_employee from './pages/salary/pay_employee.vue';
import view_employee from './pages/salary/view_employee.vue';
import view_salary from './pages/salary/view_salary.vue';
import edit_salary from './pages/salary/edit_salary.vue';
import salary_sheet from './pages/salary/all_salary.vue';

//trial balance
import trial_balance from './pages/trial_balance/trial_balance.vue';

//stock journal
import add_stock_journal from './pages/requisition/add_stock_journal.vue';
import edit_stock_journal from './pages/requisition/edit_stock_journal.vue';
import all_stock_journal from './pages/requisition/all_stock_journal.vue';
import view_stock_journal from './pages/requisition/view_stock_journal.vue';
import stock_transfer from './pages/requisition/stock_transfer.vue';
import all_stock_transfer from './pages/requisition/all_stock_transfer.vue';
import edit_stock_transfer from './pages/requisition/edit_stock_transfer.vue';
import view_stock_transfer from './pages/requisition/view_stock_transfer.vue';


//member
import add_member from './pages/project_member/add_member.vue';
import edit_member from './pages/project_member/edit_member.vue';
import view_member from './pages/project_member/view_member.vue';
import all_member from './pages/project_member/all_member.vue';
import project_base_member from './pages/project_member/project_base_member.vue';
import project_lists from './pages/project_member/project_lists.vue';
import building_lists from './pages/project_member/building_lists.vue';
import building_base_member from './pages/project_member/building_base_member.vue';
//reference
import add_reference from './pages/reference/add_reference.vue';
import edit_reference from './pages/reference/edit_reference.vue';
import all_reference from './pages/reference/all_reference.vue';
import view_reference from './pages/reference/view_reference.vue';

//manager approve
import add_manager_approve from './pages/manager_approve/add_manager_approve.vue';
import all_manager_approve from './pages/manager_approve/all_manager_approve.vue';
import edit_manager_approve from './pages/manager_approve/edit_manager_approve.vue';
import delete_manager from './pages/manager_approve/delete_manager.vue';
import accounts_access from './pages/manager_approve/accounts_access.vue';
//advance pay
import advance_pay from './pages/advance_pay/advance_pay.vue';
import all_advance_pay from './pages/advance_pay/all_advance_pay.vue';
import edit_advance_pay from './pages/advance_pay/edit_advance_pay.vue';
import view_advance_pay from './pages/advance_pay/view_advance_pay.vue';

//construction
import all_pay_construction from './pages/construction/all_pay_construction.vue';
import pay_construction from './pages/construction/pay_construction.vue';
import edit_pay_construction from './pages/construction/edit_pay_construction.vue';
import view_pay_construction from './pages/construction/view_pay_construction.vue';
import all_required_construction from './pages/construction/all_required_construction.vue';
import view_required_construction from './pages/construction/view_required_construction.vue';
import view_pay_single_construction from './pages/construction/view_pay_single_construction.vue';
import edit_required_construction from './pages/construction/edit_required_construction.vue';
import required_construction from './pages/construction/required_construction.vue';
import construction_project_list from './pages/construction/construction_project_list.vue';
import construction_building_list from './pages/construction/construction_building_list.vue';
import construction_project_base from './pages/construction/construction_project_base.vue';
import construction_building_base from './pages/construction/construction_building_base.vue';
import edit_merge_construction from './pages/construction/edit_merge_construction.vue';
import pay_merge_construction from './pages/construction/pay_merge_construction.vue';

import merge_required_construction from './pages/construction/merge_required_construction.vue';
import view_merge_construction from './pages/construction/view_merge_construction.vue';

//update  update_password
import update_password from './pages/password_change/update_password.vue';
import  help from './pages/help/help.vue';
const routes = [

    {
        path: '/',
        name: 'home',
        component: home,
    },

    ,
    {
        path: '/admin/register',
        name: 'register_admin',
        component: register_admin,
    },
    {
        path: '/admin/login',
        name: 'login_admin',
        component: login_admin,
    },
    {
        path: '/admin/dashboard',
        name: 'admin_dashboard',
        component: admin_dashboard,
    },
    {
        path: '/manager/dashboard',
        name: 'manager_dashboard',
        component: manager_dashboard,
    }
    ,
    {
        path: '/manager/login',
        name: 'login_manager',
        component: login_manager,
    },
    {
        path: '/manager/register',
        name: 'register_manager',
        component: register_manager,
    },
    {
        path: '/building/add_project',
        name: 'add_project',
        component: add_project,
    },
    {
        path: '/project/all_project',
        name: 'all_project',
        component: all_project,
    },
    {
        path: '/project/edit_project/:id',
        name: 'edit_project',
        component: edit_project,
    },
    {
        path: '/project/view_project/:id',
        name: 'view_project',
        component: view_project,
    },
    {
        path: '/project/add_stage/:id',
        name: 'add_stage',
        component: add_stage,
    },
    {
        path: '/project/edit_stage/:id',
        name: 'edit_stage',
        component: edit_stage,
    },
    {
        path: '/create_building',
        name: 'create_building',
        component: create_building,
    },
    {
        path: '/edit_building/:id',
        name: 'edit_building',
        component: edit_building,
    },
    {
        path: '/index_building',
        name: 'index_building',
        component: index_building,
    },
    {
        path: '/view_building/:id',
        name: 'view_building',
        component: view_building,
    },
    {
        path: '/client/add_client',
        name: 'add_client',
        component: add_client,
    },
    {
        path: '/client/all_client',
        name: 'all_client',
        component: all_client,
    },
    {
        path: '/client/view_client/:id',
        name: 'view_client',
        component: view_client,
    },
    {
        path: '/client/edit_client/:id',
        name: 'edit_client',
        component: edit_client,
    },
    {
        path: '/client/tin_client/:id',
        name: 'tin_client',
        component: tin_client,
    },
    {
        path: '/client/nid_client/:id',
        name: 'nid_client',
        component: nid_client,
    },
    {
        path: '/client/passport_client/:id',
        name: 'passport_client',
        component: passport_client,
    },
    {
        path: '/supplier/add_supplier',
        name: 'add_supplier',
        component: add_supplier,
    },
    {
        path: '/supplier/all_supplier',
        name: 'all_supplier',
        component: all_supplier,
    },
    {
        path: '/supplier/edit_supplier/:id',
        name: 'edit_supplier',
        component: edit_supplier,
    },
    {
        path: '/accounts/type',
        name: 'account_type',
        component: account_type,
    },
    {
        path: '/accounts/type/add',
        name: 'add_account_type',
        component: add_account_type,
    },
    {
        path: '/accounts/type/edit/:id',
        name: 'edit_account_type',
        component: edit_account_type,
    }, {
        path: '/account_head',
        name: 'account_head',
        component: account_head,
    },
    {
        path: '/account_head/add',
        name: 'add_account_head',
        component: add_account_head,
    },
    {
        path: '/account_head/edit/:id',
        name: 'edit_account_head',
        component: edit_account_head,
    },
    {
        path: '/create_receipt_voucher',
        name: 'receipt_voucher',
        component: receipt_voucher,
    },
    {
        path: '/receipt_voucher',
        name: 'all_voucher',
        component: all_voucher,
    },
    {
        path: '/receipt_view_voucher/:id',
        name: 'view_voucher',
        component: view_voucher,
    },
    {
        path: '/receipt_edit_voucher/:id',
        name: 'edit_voucher',
        component: edit_voucher,
    },
    {
        path: '/receipt_print_voucher/:id',
        name: 'print_voucher',
        component: print_voucher,
    },
    {
        path: '/receipt_document/:id',
        name: 'receipt_document',
        component: receipt_document,
    },
    {
        path: '/create_payment_voucher',
        name: 'payment_voucher',
        component: payment_voucher,
    },
    {
        path: '/payment_voucher',
        name: 'payment_all_voucher',
        component: payment_all_voucher,
    },
    {
        path: '/payment_view_voucher/:id',
        name: 'payment_view_voucher',
        component: payment_view_voucher,
    },
    {
        path: '/payment_edit_voucher/:id',
        name: 'payment_edit_voucher',
        component: payment_edit_voucher,
    },
    {
        path: '/payment_print_voucher/:id',
        name: 'payment_print_voucher',
        component: payment_print_voucher,
    },
    {
        path: '/accounts/type/edit/:id',
        name: 'edit_account_type',
        component: edit_account_type,
    }, {
        path: '/account_head',
        name: 'account_head',
        component: account_head,
    },
    {
        path: '/account_head/add',
        name: 'add_account_head',
        component: add_account_head,
    },
    {
        path: '/unit/add',
        name: 'unit',
        component: unit,
    },
    {
        path: '/unit/all',
        name: 'all_unit',
        component: all_unit,
    },
    {
        path: '/unit/edit/:id',
        name: 'edit_unit',
        component: edit_unit,
    },
    {
        path: '/accounts_payable',
        name: 'accounts_payable',
        component: accounts_payable,
    }, {
        path: '/accounts_receivable',
        name: 'accounts_receivable',
        component: accounts_receivable,
    }, {
        path: '/purchase_journal',
        name: 'purchase_journal',
        component: purchase_journal,
    }, {
        path: '/sales_journal',
        name: 'sales_journal',
        component: sales_journal,
    },
    {
        path: '/ledger',
        name: 'ledger',
        component: ledger,
    },
    {
        path: '/purchase_ledger',
        name: 'purchase_ledger',
        component: purchase_ledger,
    },
    {
        path: '/sales_ledger',
        name: 'sales_ledger',
        component: sales_ledger,
    },
    {
        path: '/apledger',
        name: 'apledger',
        component: apledger,
    },
    {
        path: '/rpledger',
        name: 'rpledger',
        component: rpledger,
    },
    {
        path: '/cash_ledger',
        name: 'cash_ledger',
        component: cash_ledger,
    },
    {
        path: '/bank_ledger',
        name: 'bank_ledger',
        component: bank_ledger,
    },
    {
        path: '/all_pay_payable',
        name: 'all_pay_payable',
        component: all_pay_payable,
    },
    {
        path: '/pay_payable',
        name: 'pay_payable',
        component: pay_payable,
    },
    {
        path: '/update_pay_payable/:id',
        name: 'edit_pay_payable',
        component: edit_pay_payable,
    },
    {
        path: '/all_pay_receivable',
        name: 'all_pay_receivable',
        component: all_pay_receivable,
    },
    {
        path: '/pay_receivable',
        name: 'pay_receivable',
        component: pay_receivable,
    },
    {
        path: '/update_pay_receivable/:id',
        name: 'edit_pay_receivable',
        component: edit_pay_receivable,
    },
    {
        path: '/all_purchase_return',
        name: 'all_purchase_return',
        component: all_purchase_return,
    },
    {
        path: '/purchase_return',
        name: 'purchase_return',
        component: purchase_return,
    },
    {
        path: '/update_purchase_return/:id',
        name: 'edit_purchase_return',
        component: edit_purchase_return,
    },
    {
        path: '/create_sales',
        name: 'create_sales',
        component: create_sales,

    },
    {
        path: '/create_sales_building',
        name: 'create_sales_building',
        component: create_sales_building,

    },
    {
        path: '/sales_project',
        name: 'sales_project',
        component: sales_project,

    },
    {
        path: '/sales_building/:id',
        name: 'sales_building',
        component: sales_building,

    },

    {
        path: '/inventories',
        name: 'all_sales',
        component: all_sales,
    },
    {
        path: '/edit_sales/:id',
        name: 'edit_sales',
        component: edit_sales,
    },
    {
        path:'/view_sales/:id',
        name:'view_sales',
        component: view_sales,
    },
    {
        path: '/add_purchase_land',
        name: 'add_purchase_land',
        component: add_purchase_land,
    },
    {
        path: '/all_purchase_land',
        name: 'all_purchase_land',
        component: all_purchase_land,
    },
    {
        path: '/edit_purchase_land/:id',
        name: 'edit_purchase_land',
        component: edit_purchase_land,
    },
    {
        path: '/view_purchase_land/:id',
        name: 'view_purchase_land',
        component: view_purchase_land,
    }
    ,
    {
        path: '/add_expense',
        name: 'add_expense',
        component: add_expense,
    },

    {
        path: '/edit_expense/:id',
        name: 'edit_expense',
        component: edit_expense,
    },

    {
        path: '/all_expense',
        name: 'all_expense',
        component: all_expense,
    },
    {
        path:'/view_expense/:id',
        name:'view_expense',
        component:view_expense,
    },

    {
        path: '/add_employee',
        name: 'add_employee',
        component: add_employee,
    },

    {
        path: '/edit_employee/:id',
        name: 'edit_employee',
        component: edit_employee,
    },

    {
        path: '/all_employee',
        name: 'all_employee',
        component: all_employee,
    },
    {
        path:"/salary_sheet",
        name:'salary_sheet',
        component:salary_sheet,
    },
     {
        path: '/pay_employee/:id',
        name: 'pay_employee',
        component: pay_employee,
    },
    {
        path:'/view_employee/:id',
        name:'view_employee',
        component:view_employee,
    },
    {
        path:'/view_salary/:id',
        name:'view_salary',
        component:view_salary,
    },
    {
        path:'/edit_salary/:id',
        name:'edit_salary',
        component:edit_salary,
    },
    {
        path:'/trial_balance',
        name:'trial_balance',
        component:trial_balance,
    },

    {
        path:'/add_stock_journal',
        name:'add_stock_journal',
        component:add_stock_journal,
    },{
        path:'/edit_stock_journal/:id',
        name:'edit_stock_journal',
        component:edit_stock_journal,
    },{
        path:'/all_stock_journal',
        name:'all_stock_journal',
        component:all_stock_journal,
    },
    {
        path:'/view_stock_journal',
        name:'view_stock_journal',
        component:view_stock_journal,
    },
    {
        path:'/view_reference/:id',
        name:'view_reference',
        component:view_reference,
    },
    {
        path:'/add_reference',
        name:'add_reference',
        component:add_reference,
    },
    {
        path:'/edit_reference/:id',
        name:'edit_reference',
        component:edit_reference,
    },
    {
        path:'/all_reference',
        name:'all_reference',
        component:all_reference,
    },
    {
        path:'/add_member',
        name:'add_member',
        component:add_member,
    },
    {
        path:'/edit_member/:id',
        name:'edit_member',
        component:edit_member,
    },
    {
        path:'/view_member/:id',
        name:'view_member',
        component:view_member,
    },
    {
        path:'/all_member',
        name:'all_member',
        component:all_member,
    },
    {
        path:'/project_base_member/:id',
        name:'project_base_member',
        component:project_base_member,
    },
    {
        path:'/project_lists',
        name:'project_lists',
        component:project_lists,
    },
    {
        path:'/add_manager_approve',
        name:'add_manager_approve',
        component:add_manager_approve,
    },
    {
        path:'/all_manager_approve',
        name:'all_manager_approve',
        component:all_manager_approve,
    },
    {
        path:'/delete_manager',
        name:'delete_manager',
        component:delete_manager,
    },
    {
        path:'/edit_manager_approve/:id',
        name:'edit_manager_approve',
        component:edit_manager_approve,
    },
    {
        path:'/update_password',
        name:'update_password',
        component:update_password,
    },
    {
        path:'/accounts_access',
        name:'accounts_access',
        component:accounts_access,
    },{
        path:'/payment_history',
        name:'payment_history',
        component:payment_history,
    },
    {
        path:'/receipt_history',
        name:'receipt_history',
        component:receipt_history,
    },
    {
        path:'/edit_payment_history/:id',
        name:'edit_payment_history',
        component:edit_payment_history,
    },
    {
        path:'/view_receipt_history/:id',
        name:'view_receipt_history',
        component:view_receipt_history,
    },{
        path:'/edit_receipt_history/:id',
        name:'edit_receipt_history',
        component:edit_receipt_history,
    },{
        path:'/view_payment_history/:id',
        name:'view_payment_history',
        component:view_payment_history,
    },
    {
        path:'/update_payment_history/:id',
        name:'update_payment_history',
        component:update_payment_history,
    },{
        path:'/update_receipt_history/:id',
        name:'update_receipt_history',
        component:update_receipt_history,
    },
    {
        path:'/advance_pay',
        name:'advance_pay',
        component:advance_pay,
    },
    {
        path:'/all_advance_pay',
        name:'all_advance_pay',
        component:all_advance_pay,
    },{
        path:'/edit_advance_pay/:id',
        name:'edit_advance_pay',
        component:edit_advance_pay,
    },
    {
        path:'/view_advance_pay/:id',
        name:'view_advance_pay',
        component:view_advance_pay,
    },{
        path:'/view_pay_construction/:id',
        name:"view_pay_construction",
        component:view_pay_construction,
    },
    {
        path:'/view_pay_single_construction/:id',
        name:"view_pay_single_construction",
        component:view_pay_single_construction,

    },
     {
        path:'/stock_transfer/:id',
        name:"stock_transfer",
        component:stock_transfer,

    },
     {
        path:'/all_stock_transfer',
        name:"all_stock_transfer",
        component:all_stock_transfer,

    },
    {
        path:'/view_stock_transfer/:id',
        name:"view_stock_transfer",
        component:view_stock_transfer,

    },
    {
        path:'/edit_stock_transfer/:id',
        name:"edit_stock_transfer",
        component:edit_stock_transfer,

    },
    {
        path:'/edit_pay_construction/:id',
        name:"edit_pay_construction",
        component:edit_pay_construction,
    },
    {
        path:'/pay_construction/:id',
        name:"pay_construction",
        component:pay_construction,
    },
    {
        path:'/all_pay_construction',
        name:"all_pay_construction",
        component:all_pay_construction,
    },
    {
        path:'/view_required_construction/:id',
        name:"view_required_construction",
        component:view_required_construction,
    },
    {
        path:'/edit_required_construction/:id',
        name:"edit_required_construction",
        component:edit_required_construction,
    },
    {
        path:'/all_required_construction',
        name:"all_required_construction",
        component:all_required_construction,
    },
    {
        path:'/edit_merge_construction/:id',
        name:"edit_merge_construction",
        component:edit_merge_construction,
    },
    {
        path:'/merge_required_construction',
        name:"merge_required_construction",
        component:merge_required_construction,
    },
    {
        path:'/view_merge_construction/:id',
        name:"view_merge_construction",
        component:view_merge_construction,
    },
    {
        path:'/required_construction',
        name:"required_construction",
        component:required_construction,
    },
    {
        path:'/building_lists',
        name:"building_lists",
        component:building_lists,
    },
    {
        path:'/building_base_member/:id',
        name:"building_base_member",
        component:building_base_member,
    },
    {
        path:'/construction_project_list',
        name:"construction_project_list",
        component:construction_project_list,
    }, {
        path:'/construction_project_base/:id',
        name:"construction_project_base",
        component:construction_project_base,
    }, {
        path:'/construction_building_list',
        name:"construction_building_list",
        component:construction_building_list,
    }, {
        path:'/construction_building_base/:id',
        name:"construction_building_base",
        component:construction_building_base,
    },
    {
        path:'/pay_merge_construction/:id',
        name:"pay_merge_construction",
        component:pay_merge_construction,
    },
    {
        path:'/help',
        name:"help",
        component:help,
    },
    {
        path:'/all_category',
        name:"all_category",
        component:all_category,
        
    },{
        path:'/late_fine',
        name:"late_fine",
        component:late_fine,
    }
];

const router = createRouter({
    mode: 'history',
    history: createWebHistory(),
    routes,
});

export default router;
