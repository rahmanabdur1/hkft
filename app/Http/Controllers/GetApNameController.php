<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\payable_journal;
use App\Models\Inventory;
use App\Models\Admin;
use App\Models\Manager;
use App\Models\ReceiptPayableJournal;
use App\Models\PaymentHistory;
use App\Models\ReceiptHistory;
use App\Models\ConstructionPay;
use App\Models\PurchaseLand;
use App\Models\ConstructionRequired;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\Building;

class GetApNameController extends Controller
{
    //

    public function getReference($voucher)
    {
        $index = DB::table('references')->where('voucher_no', $voucher)->first();
        return response()->json($index);
    }
    public function getApName(Request $request)
    {
        $index = DB::table('payment_vouchers')->where('payment_id', $request->payment_id)->first();

        return response()->json($index);
    }

    public function getApLedger()
    {
        $index = DB::table('pay_payables')->join('payable_journals', 'pay_payables.payment_id', '=', 'payable_journals.payment_id')->select('pay_payables.*')->get();
        return response()->json($index);
    }
    public function getApledgerRcpt()
    {
        $index = DB::table('pay_receivables')->join('receipt_payable_journals', 'pay_receivables.receipt_id', '=', 'receipt_payable_journals.receipt_id')->select('pay_receivables.*')->get();
        return response()->json($index);
    }

    public function getPayableData($payment_id)
    {
        $getData = DB::table('pay_payables')->join('payable_journals', 'pay_payables.payment_id', '=', 'payable_journals.payment_id')->select('pay_payables.*', 'payable_journals.payee_name')->where('pay_payables.payment_id', $payment_id)->latest('created_at')->first();

        return response()->json($getData);
    }
    public function checkDueClear($payment_id)
    {
        $getData = DB::table('pay_payables')->where('payment_id', $payment_id)->first();
        return response()->json($getData);
    }

    public function checkDueClearReceipt($receipt_id)
    {
        $getData = DB::table('pay_receivables')->where('receipt_id', $receipt_id)->first();
        return response()->json($getData);
    }

    public function getPayableID($payment_id)
    {

        $index = DB::table('pay_payables')->where('payment_id', $payment_id)->first();
        if ($index) {
            return response()->json(['id' => $index]);
        } else {
            return response()->json(['id' => 'empty']);
        }
    }

    public function getPaymentVoucher($payment_id)
    {
        $index = DB::table('payment_vouchers')->where('payment_id', $payment_id)->first();
        return response()->json($index);
    }
    public function checkReturns($payment_id)
    {
        $index = DB::table('purchase_returns')->where('payment_id', $payment_id)->first();
        return response()->json($index);
    }

    public function getName($payment_id)
    {
        $index = DB::table('payment_vouchers')->where('payment_id', $payment_id)->first();
        return response()->json($index);
    }

    public function checkPropertyId(Request $request)
    {
        $project = $request->property_project;
        $building_name = $request->building_name;
        $notEmpty = Inventory::all();
        if (count($notEmpty) > 0) {
            if ($request->property_type == "Building") {
                $checkProject = DB::table('inventories')->where('property_project', $project)->first();
                if ($checkProject) {
                    $index = DB::table('inventories')->where('building_name', $building_name)->where('property_name', $request->property_name)->first();


                    return response()->json($index);
                }
            } else {
                $index = DB::table('inventories')->where('property_id', $request->property_id)->first();
                return response()->json($index);
            }
        }
    }

    public function filterProductType(Request $request)
    {
        if (strtolower($request->property_type) == 'land') {
            $index = DB::table('inventories')->whereRaw('lower(property_type) = ?', 'land')->where('property_status', 'Available')->get();
            return response()->json($index);
        } else if ($request->selectedProject != "" || strtolower($request->property_type) != 'land') {
            $index = DB::table('inventories')->whereRaw('lower(property_type) != ?', 'land')->where('property_status', 'Available')->where('property_project', $request->selectedProject)->get();

            return response()->json($index);
        }
    }

    public function getBuildingName(Request $request)
    {
        $index = DB::table('buildings')->join('projects',function($query){
            $query->on('buildings.projects_id','projects.id');
        })->where('projects.project_name', $request->selectedProject)->select('buildings.building_name')->groupBy('building_name')->get();
        // $index = DB::table('inventories')->select('inventories.building_name')->where('property_status', 'Available')->where('property_type', 'Building')->where('property_project', $request->selectedProject)->distinct()->get();
        return response()->json($index);
    }

    public function getPropertyLabel(Request $request)
    {
        $index = DB::table('inventories')->select('inventories.*')->where('property_project', $request->selectedProject)->where('property_status', 'Available')->where('building_name', $request->building_name)->where('sub_property_type', $request->selected_label)->get();
        return response()->json($index);
    }

    public function getPropertyId(Request $request)
    {
        return response()->json($request);
    }

    public function getProductTotal(Request $request)
    {
        $getIdByBuildingName = DB::table('inventories')->where('building_name', $request->building_name)->where('property_project', $request->selectedProject)->first();
        $data = array();
        $data['property_id'] = $getIdByBuildingName->property_id;
        $totalAmount = 0;
        $getDataByBuildingName = DB::table('inventories')->where('property_id', $getIdByBuildingName->property_id)->where('property_status', 'Available')->get();
        if ($getDataByBuildingName) {
            foreach ($getDataByBuildingName as $gdb) {
                $totalAmount += $gdb->property_amount;
            }
        }
        $data['product_amount'] = $totalAmount;
        return response()->json($data);
    }

    public function getFirstInstall($payment_id)
    {
        $index1 = DB::table('pay_payables')->where('payment_id', $payment_id)->first();
        $index2 = DB::table('payment_vouchers')->where('payment_id', $payment_id)->first();
        $data = [
            'total_received' => $index2->receive_amount,
            'due_clear' => $index1->receive_amount,
        ];
        return response()->json($data);
    }
    public function getFirstInstallReceipt($receipt_id)
    {
        $index1 = DB::table('pay_receivables')->where('receipt_id', $receipt_id)->first();
        $index2 = DB::table('receipt_vouchers')->where('receipt_id', $receipt_id)->first();
        $data = [
            'total_received' => $index2->total_amount,
            'due_clear' => $index1->receive_amount,
        ];
        return response()->json($data);
    }

    public function getReceiptName($receipt_id)
    {
        $index = DB::table('receipt_vouchers')->where('receipt_id', $receipt_id)->first();
        return response()->json($index);
    }

    public function getPurchaseAmount()
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateWeeklyPurchase()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function getSalesAmount()
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateWeeklySalesAmount()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateWeeklyPaymentDue()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function getPaymentDue()
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }

    public function getReceiptDue()
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }


    public function calculateWeeklyReceiptDue()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateWeeklyGetExpense()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('expenses')->select('expenses.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateWeeklyGetSalary()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->copy()->subDays(7)->format('Y-m-d');
        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date', [$endDate, $startDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    //daily
    public function calculateDailyGetExpense()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('expenses')->select('expenses.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateDailyGetSalary()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('salaries')->select('salaries.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateDailyPurchase()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateDailySalesAmount()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateDailyPaymentDue()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateDailyReceiptDue()
    {
        $startDate = Carbon::now()->format('Y-m-d');

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('basic_date', $startDate)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }


    //monthly
    public function calculateMonthlyPurchase()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateMonthlySalesAmount()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateMonthlyPaymentDue()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateMonthlyReceiptDue()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateMonthlyGetExpense()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('expenses')->select('expenses.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateMonthlyGetSalary()
    {
        $startDate = Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');
        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    //yearly
    public function calculateYearlyPurchase()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateYearlySalesAmount()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateYearlyPaymentDue()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateYearlyReceiptDue()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateYearlyGetExpense()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('expenses')->select('expenses.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateYearlyGetSalary()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    //date

    public function calculateDatePurchase(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateDateSalesAmount(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateDatePaymentDue(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateDateReceiptDue(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateDateGetExpense(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('expenses')->select('expenses.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function fetchAdminStock()
    {
        return DB::table('stocks')->select('stocks.project')->distinct()->get();
    }
    public function fetchManagerStock($project)
    {
        return DB::table('stocks')->select('stocks.*')->where('project', $project)->get();
    }
    public function fetchSelectedStockProjectBuilding($project)
    {
        return DB::table('stocks')->where('project', $project)->select('stocks.selectedBuilding')->distinct()->get();
    }
    public function fetchStockProjectBuilding($building)
    {
        return DB::table('stocks')->where('selectedBuilding', $building)->get();
    }
    public function purchase_land_details_update(Request $request)
    {
        $PurchaseLand =  PurchaseLand::find($request->id);
        $PurchaseLand->land_office = $request->land_office;
        $PurchaseLand->moujar = $request->moujar;
        $PurchaseLand->thana = $request->thana;
        $PurchaseLand->district = $request->district;
        $PurchaseLand->owner_name = $request->owner_name;
        $PurchaseLand->holding_number = $request->holding_number;
        $PurchaseLand->land_class = $request->land_class;
        $PurchaseLand->ledger_no = $request->ledger_no;
        $PurchaseLand->dag_no = $request->dag_no;

        if ($request->hasFile("Supporting_docs")) {
            $file = $request->file('Supporting_docs');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('purchase_lands')->where('id', $request->id)->first();
            if ($database_doc->Supporting_docs != "") {
                $old_doc = public_path($PurchaseLand->Supporting_docs);

                unlink($old_doc);
                $PurchaseLand->Supporting_docs = 'documents/' . $filename;
            } else if ($database_doc->Supporting_docs === "") {

                $PurchaseLand->Supporting_docs = 'documents/' . $filename;
            }
        } else {
            $database_doc = DB::table('purchase_lands')->where('id', $request->id)->first();
            $PurchaseLand->Supporting_docs = $database_doc->Supporting_docs;
        }
        $PurchaseLand->save();

        return response()->json($request);
    }

    public function fetchStockByProjectTransfer($project)
    {
        return DB::table('stock_transfers')->where('fromProject', $project)->distinct()->get();
    }
    public function fetchBuildingInStockTransfer($project)
    {
        return DB::table('stock_transfers')->where('fromProject', $project)->select('stock_transfers.fromBuilding')->distinct()->get();
    }
    public function fetchStockByBuildingTransfered($building)
    {
        return DB::table('stock_transfers')->where('fromBuilding', $building)->get();
    }
    public function fetchStockByProjectTransferTo($project)
    {
        return DB::table('stock_transfers')->where('selectedProject', $project)->distinct()->get();
    }
    public function fetchBuildingInStockTransferTo($project)
    {
        return DB::table('stock_transfers')->where('selectedProject', $project)->select('stock_transfers.selectedBuilding')->distinct()->get();
    }
    public function fetchStockByBuildingTransferedTo($building)
    {
        return DB::table('stock_transfers')->where('selectedBuilding', $building)->get();
    }
    public function stockBaseDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('stocks')->select('stocks.*')->whereBetween('stock_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function stockBaseDateAll(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('stocks')->select('stocks.*')->where('project', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->where('product_name', $request->product_name)->whereBetween('stock_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchManagerProject($name)
    {
        $index = DB::table('manager_approves')->where('manager_name', $name)->get();
        return response()->json($index);
    }
    public function getStocks()
    {
        $index = DB::table('stocks')->select('stocks.*')->get();
        return response()->json($index);
    }
    public function calculateDateGetSalary(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date', [$startDate, $endDate])->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }



    //project
    public function calculateProjectGetExpense($project)
    {
        $index = DB::table('expenses')->select('expenses.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateProjectGetSalary($project)
    {
        $index = DB::table('salaries')->select('salaries.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateProjectPurchase($project)
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateProjectSalesAmount($project)
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateProjectPaymentDue($project)
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateProjectReceiptDue($project)
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('selectedProject', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }

    //building
    public function calculateBuildingGetExpense($project)
    {
        $index = DB::table('expenses')->select('expenses.*')->where('building_name', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateBuildingGetSalary($project)
    {
        $index = DB::table('salaries')->select('salaries.*')->where('selectedBuilding', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->basic_salary) + intval($ind->commission);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateBuildingPurchase($project)
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('building_name', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->receive_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateBuildingSalesAmount($project)
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('building_name', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->total_amount);
            }
        }
        return response()->json($totalBalance);
    }

    public function calculateBuildingPaymentDue($project)
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('building_name', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->payment_due);
            }
        }
        return response()->json($totalBalance);
    }
    public function calculateBuildingReceiptDue($project)
    {

        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->where('building_name', $project)->get();
        $totalBalance = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalBalance += intval($ind->due);
            }
        }
        return response()->json($totalBalance);
    }


    //
    public function pieChart()
    {
        $indexArray = [];
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->get();
        if ($index) {
            foreach ($index as $ind) {
                $indexArray[] = [

                    $ind->selectedProject,
                    $ind->total_amount,
                ];
            }
        }
        return response()->json($indexArray);
    }

    public function areaChart()
    {
        $indexArray = [];
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.*')->get();
        if ($index) {
            foreach ($index as $ind) {
                $indexArray[] = [

                    $ind->basic_date,
                    ($ind->total_amount),
                ];
            }
        }
        return response()->json($indexArray);
    }

    public function fetchStock($product_name)
    {
        $index = DB::table('stocks')->where('product_name', $product_name)->first();
        return response()->json($index);
    }
    public function sendForStocks(Request $request)
    {
        $index = DB::table('stocks')->where('product_name', $request->product_name)->where('project', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->first();
        return response()->json($index);
    }

    public function getUnit($product_name)
    {
        $index = DB::table('units')->where('item_name', $product_name)->first();
        return response()->json($index);
    }

    public function getStage($id)
    {
        $index  = DB::table('project_stages')->where('id', $id)->first();
        return response()->json($index);
    }
    public function reference_clients(Request $request)
    {
        $index = DB::table('references')->where('reference_id', $request->reference_id)->get();
        return response()->json($index);
    }

    public function project_lists()
    {
        $index = DB::table('project_members')->select('project_members.project', DB::raw('MIN(id) as id'))->groupBy('project')->get();
        return response()->json($index);
    }
    public function fetchProjectFromLists($id)
    {
        $getProjectName = DB::table('project_members')->where('id', $id)->select('project_members.project')->first();
        return response()->json($getProjectName);
    }
    public function fetchMemberByProject($project)
    {
        $index = DB::table('project_members')->where('project', $project)->get();
        return response()->json($index);
    }

    public function getAllManager()
    {
        $index = DB::table('managers')->get();
        return response()->json($index);
    }

    public function managerUsername($username)
    {
        $index = DB::table('managers')->where('username', $username)->first();
        return response()->json($index);
    }


    public function getManagerProject($username)
    {
        $index = DB::table('manager_approves')->where('manager_name', $username)->get();
        return response()->json($index);
    }
    public function getManagerProjectClient($project)
    {
        $index = DB::table('clients')->where('clientUnderProject', $project)->get();
        return response()->json($index);
    }

    public function getClientAllProject($client)
    {
        $index = DB::table('receipt_vouchers')->where('client_id', $client)->get();
        return response()->json($index);
    }

    public function getManagerAll()
    {
        $index = Manager::all();
        return response()->json($index);
    }
    public function manager_delete($id)
    {
        $index = DB::table('managers')->where('id', $id)->first();
        DB::table('manager_approves')->where('manager_name', $index->username)->delete();
        DB::table('managers')->where('id', $id)->delete();
    }



    public function update_admin_current_password(Request $request)
    {
        $admin = DB::table("admins")->where('username', $request->username)->first();

        if ($admin && Hash::check($request->old_password, $admin->password)) {
            DB::table('admins')->where('username', $request->username)->update(['password' => Hash::make($request->new_password)]);
            return response()->json(['success' => 'Password Changed Successfully']);
        } else {
            return response()->json(['error' => 'Old password is incorrect']);
        }
    }
    public function update_manager_current_password(Request $request)
    {
        $admin = DB::table("managers")->where('username', $request->username)->first();

        if ($admin && Hash::check($request->old_password, $admin->password)) {
            DB::table('managers')->where('username', $request->username)->update(['password' => Hash::make($request->new_password)]);
            return response()->json(['success' => 'Password Changed Successfully']);
        } else {
            return response()->json(['error' => 'Old password is incorrect']);
        }
    }
    public function reset_notification()
    {
        $index = DB::table('notifications')->latest('created_at')->update(['notification' => 0]);
    }

    public function fetch_access($manager)
    {
        $index = DB::table('accounts_accesses')->where('manager_name', $manager)->first();
        return response()->json($index);
    }
    public function getReceiptvouchers($project)
    {
        $index = DB::table('receipt_vouchers')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function getPaymentvouchers($project)
    {
        $index = DB::table('payment_vouchers')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function getManagerPayable($project)
    {
        $getPayable = DB::table('pay_payables')->pluck('payment_id');

        $index = payable_journal::whereNotIn('payment_id', $getPayable)->where('project', $project)->get();
        return response()->json($index);
    }

    public function getManagerPayableAll($project)
    {
        $index = DB::table('pay_payables')->where('project', $project)->join('payable_journals', 'pay_payables.payment_id', '=', 'payable_journals.payment_id')->select('pay_payables.*')->get();
        return response()->json($index);
    }
    public function getManagerReceivableAll($project)
    {

        $index = DB::table('pay_receivables')->where('project', $project)->join('receipt_payable_journals', 'pay_receivables.receipt_id', '=', 'receipt_payable_journals.receipt_id')->select('pay_receivables.*')->get();
        return response()->json($index);
    }
    public function getManagerReceiptPayable($project)
    {
        $getPayable = DB::table('pay_receivables')->pluck('receipt_id');

        $index = ReceiptPayableJournal::whereNotIn('receipt_id', $getPayable)->where('project', $project)->get();
        return response()->json($index);
    }

    public function manager_fetch_employee($project)
    {
        $index = DB::table('employees')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function manager_fetch_salary($project)
    {
        $index = DB::table('salaries')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function manager_fetch_expense($project)
    {
        $index = DB::table('expenses')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function construction_project_list()
    {
        $index = DB::table('construction_requireds')->select('construction_requireds.selectedProject')->where('selectedProject', '!=', null)->distinct()->get();
        return response()->json($index);
    }
    public function construction_building_list()
    {
        $index = DB::table('construction_requireds')->select('construction_requireds.selectedBuilding')->where('selectedBuilding', '!=', null)->distinct()->get();
        return response()->json($index);
    }
    public function fetch_client()
    {
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.selectedProject')->where('selectedProject', '!=', null)->distinct()->get();
        return response()->json($index);
    }
    public function fetch_all_buildling()
    {
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.building_name')->where('building_name', '!=', null)->distinct()->get();
        return response()->json($index);
    }

    public function fetch_construction_by_project($project)
    {
        $index = DB::table('construction_pays')->where('selectedProject', $project)->select('construction_pays.client_id')->distinct()->get();
        return response()->json($index);
    }
    public function fetch_client_by_project_in_building($building)
    {
        $index = DB::table('receipt_vouchers')->where('building_name', $building)->select('receipt_vouchers.client_id')->distinct()->get();
        return response()->json($index);
    }
    public function fetch_client_by_project($project)
    {
        $indexarray = [];
        $client_get = DB::table('receipt_vouchers')->where('selectedProject', $project)->get();
        if ($client_get) {

            foreach ($client_get as $cg) {
                $totalPaid = 0;
                $totalDue = 0;
                $totalAmount = 0;
                $count = 0;
                $commonClient = DB::table('receipt_vouchers')->where('client_id', $cg->client_id)->where('selectedProject', $project)->get();
                if (count($commonClient) > 0) {
                    foreach ($commonClient as $cc) {
                        $totalAmount += intval($cc->product_amount);
                        $totalDue += intval($cc->due);
                        $totalPaid += intval($cc->total_amount);
                        $count++;
                        $client = DB::table('clients')->where('client_id', $cg->client_id)->first();
                        $advance = DB::table('advance_pays')->where('selectedProject', $cg->selectedProject)->where('client_id', $cg->client_id)->get();
                        $amount = 0;
                        if ($advance) {
                            foreach ($advance as $ad) {
                                $amount += intval($ad->amount);
                            }
                        }
                    }
                }

                $indexarray[] = [
                    'total_amount' => $totalAmount,
                    'total_due' => $totalDue,
                    'total_paid' => $totalPaid,
                    'client_name' => $client->name,
                    'phone' => $client->phone,
                    'share' => $count,
                    'advance' => $amount,
                ];
            }
        }

        return response()->json($indexarray);
    }
    public function getManagerBuildingListConstruction($project)
    {
        $index = DB::table('construction_requireds')->where('selectedProject', $project)->select('selectedBuilding')->groupBy('selectedBuilding')->get();
        return response()->json($index);
    }
    public function fetch_construction_project_accounts($project)
    {
        // $indexarray=[];
        // $totalPaid = 0;
        // $totalDue = 0;
        // $totalAmount = 0;
        // $construction_requireds = DB::table('construction_requireds')->where('selectedProject',$project)->get();


        // foreach($construction_requireds as $cr){
        //     $clients = DB::table('clients')->where('client_id',$cr->client_id)->first();

        //     $totalRequired = 0;
        //     $totalPaid =0;
        //     $totalDue = 0;
        //     $totalExtra=0;
        //     $count=0;



        //         $allDataClient =  DB::table('construction_requireds')->where('client_id',$cr->client_id)->where('selectedProject',$project)->distinct()->get();
        //         foreach($allDataClient as $adc){
        //             $totalRequired += intval($adc->required_amount);
        //             $totalPaid += intval($adc->paid_amount);
        //             $totalDue += intval($adc->due_amount);
        //             $totalExtra += intval($adc->extra_amount);
        //             $client_id = $adc->client_id;
        //             $count+= intval($adc->share);


        //         }


        //         $indexarray [] = [
        //             'total_amount'=>$totalRequired,
        //             'total_due'=>$totalDue,
        //             'total_paid'=>$totalPaid,
        //             'client_name'=>$clients->name,
        //             'phone'=>$clients->phone,

        //             'advance'=>$totalExtra,
        //             'share'=>$count,
        //             'client_id'=>$client_id,
        //         ];


        // }

        // return response()->json($indexarray);
        // new
        $indexArray = [];
        $construction_requireds = DB::table('construction_requireds')->where('selectedProject', $project)->get();
        if (count($construction_requireds) > 0) {
            foreach ($construction_requireds as $cr) {

                $totalRequired = 0;
                $totalPaid = 0;
                $totalDue = 0;
                $totalExtra = 0;
                $client_id = "";
                $count = 0;
                $clientInfoRrequired = DB::table('construction_requireds')->where('client_id', $cr->client_id)->where('selectedProject', $project)->get();
                if (count($clientInfoRrequired) > 0) {
                    foreach ($clientInfoRrequired as $ci) {
                        $totalRequired += intval($ci->required_amount);
                    }
                }

                $clientInfoPaid = DB::table('construction_pays')->where('selectedProject', $project)->where('client_id', $cr->client_id)->get();
                if (count($clientInfoPaid) > 0) {
                    foreach ($clientInfoPaid as $ci) {
                        $totalPaid += intval($ci->paid_amount);
                    }
                }
                if (intval($totalPaid) < intval($totalRequired)) {
                    $totalDue = intval($totalRequired) - intval($totalPaid);
                } else {
                    $totalDue = 0;
                }
                if (intval($totalPaid) < intval($totalRequired)) {
                    $totalExtra = 0;
                } else {
                    $totalExtra = intval($totalPaid) - intval($totalRequired);
                }
                $clients = DB::table('clients')->where('client_id', $cr->client_id)->first();
                $indexArray[] = [
                    'total_amount' => $totalRequired,
                    'total_due' => $totalDue,
                    'total_paid' => $totalPaid,
                    'client_name' => $clients->name,
                    'phone' => $clients->phone,

                    'advance' => $totalExtra,
                    'share' => $cr->share,
                    'client_id' => $cr->client_id,
                ];
            }
        }
        return response()->json($indexArray);
    }
    public function fetch_construction_project_accounts_building($project)
    {
        $indexArray = [];
        $construction_requireds = DB::table('construction_requireds')->where('selectedBuilding', $project)->get();
        if (count($construction_requireds) > 0) {
            foreach ($construction_requireds as $cr) {

                $totalRequired = 0;
                $totalPaid = 0;
                $totalDue = 0;
                $totalExtra = 0;
                $client_id = "";
                $count = 0;
                $clientInfoRrequired = DB::table('construction_requireds')->where('client_id', $cr->client_id)->where('selectedBuilding', $project)->get();
                if (count($clientInfoRrequired) > 0) {
                    foreach ($clientInfoRrequired as $ci) {
                        $totalRequired += intval($ci->required_amount);
                    }
                }

                $clientInfoPaid = DB::table('construction_pays')->where('selectedBuilding', $project)->where('client_id', $cr->client_id)->get();
                if (count($clientInfoPaid) > 0) {
                    foreach ($clientInfoPaid as $ci) {
                        $totalPaid += intval($ci->paid_amount);
                    }
                }
                if (intval($totalPaid) < intval($totalRequired)) {
                    $totalDue = intval($totalRequired) - intval($totalPaid);
                } else {
                    $totalDue = 0;
                }
                if (intval($totalPaid) < intval($totalRequired)) {
                    $totalExtra = 0;
                } else {
                    $totalExtra = intval($totalPaid) - intval($totalRequired);
                }
                $clients = DB::table('clients')->where('client_id', $cr->client_id)->first();
                $indexArray[] = [
                    'total_amount' => $totalRequired,
                    'total_due' => $totalDue,
                    'total_paid' => $totalPaid,
                    'client_name' => $clients->name,
                    'phone' => $clients->phone,
                    'advance' => $totalExtra,
                    'share' => $cr->share,
                    'client_id' => $cr->client_id,
                ];
            }
        }
        return response()->json($indexArray);
    }
    public function fetch_client_accounts_in_building($building)
    {
        $indexarray = [];

        $client_get = DB::table('receipt_vouchers')->where('building_name', $building)->get();
        if ($client_get) {
            foreach ($client_get as $cg) {
                $totalPaid = 0;
                $totalDue = 0;
                $totalAmount = 0;
                $count = 0;
                $commonClient = DB::table('receipt_vouchers')->where('client_id', $cg->client_id)->where('building_name', $building)->get();

                if (count($commonClient) > 0) {
                    foreach ($commonClient as $cc) {

                        $totalAmount += intval($cc->product_amount);
                        $totalDue += intval($cc->due);
                        $totalPaid += intval($cc->total_amount);
                        $count++;
                        $client = DB::table('clients')->where('client_id', $cg->client_id)->first();
                        $advance = DB::table('advance_pays')->where('selectedProject', $cc->selectedProject)->where('selectedBuilding', $building)->where('client_id', $cg->client_id)->get();
                        $amount = 0;
                        if ($advance) {
                            foreach ($advance  as $ad) {
                                $amount += intval($ad->amount);
                            }
                        }
                    }
                }

                $indexarray[] = [
                    'total_amount' => $totalAmount,
                    'total_due' => $totalDue,
                    'total_paid' => $totalPaid,
                    'client_name' => $client->name,
                    'phone' => $client->phone,
                    'share' => $count,
                    'advance' => $amount,
                    'client_id' => $cg->client_id,
                ];
            }
        }

        return response()->json($indexarray);
    }
    public function getManagerProjectClientList($project)
    {
        $index = DB::table('receipt_vouchers')->where('receipt_vouchers.selectedProject', $project)->select('receipt_vouchers.selectedProject')->distinct()->get();
        return response()->json($index);
    }
    public function getManagerProjectClientListConstruction($project)
    {
        $index = DB::table('construction_requireds')->where('construction_requireds.selectedProject', $project)->select('construction_requireds.selectedProject')->distinct()->get();
        return response()->json($index);
    }
    public function gettListByBuilding($project)
    {
        $index = DB::table('receipt_vouchers')->where('receipt_vouchers.selectedProject', $project)->select('receipt_vouchers.building_name')->distinct()->get();
        return response()->json($index);
    }
    public function project($project)
    {
        $index = DB::table('projects')->where('project_name', $project)->select('projects.project_address')->first();
        return response()->json($index);
    }
    public function fetch_access_manager()
    {
        $index = DB::table('accounts_accesses')->get();
        return response()->json($index);
    }
    public function delete_accounts_access($id)
    {
        Db::table('accounts_accesses')->where('id', $id)->delete();
    }

    public function getUnitItem($product)
    {
        $unit = DB::table('units')->where('item_name', $product)->first();
        return response()->json($unit);
    }

    public function getSingleProjectClient($project)
    {

        $index = DB::table('clients')->where('clientUnderProject', $project)->get();
        return response()->json($index);
    }

    public function fetchSingleProjectClient()
    {

        $index = DB::table('clients')->select('clients.clientUnderProject')->distinct()->get();
        return response()->json($index);
    }

    public function fetchFilterProject()
    {
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.selectedProject')->whereNotNull('receipt_vouchers.selectedProject')->distinct()->get();
        return response()->json($index);
    }

    public function fetchSelectedProject($project)
    {
        $index = DB::table('receipt_vouchers')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function fetchSelectedStockProject($project)
    {
        return DB::table('stocks')->where('project', $project)->get();
    }
    public function fetchSelectedBuilding($building_name)
    {
        $index = DB::table('receipt_vouchers')->where('building_name', $building_name)->get();
        return response()->json($index);
    }


    public function fetchBuildingFromProject($project)
    {
        $index = DB::table('receipt_vouchers')->where('selectedProject', $project)->select('receipt_vouchers.building_name')->distinct()->get();
        return response()->json($index);
    }
    public function fetchBuildingFromProjectInPayment($project)
    {
        $index = DB::table('inventories')->where('property_project', $project)->select('inventories.building_name')->distinct()->get();
        return response()->json($index);
    }

    public function fetchBuildingFromPayment($project)
    {
        $index = DB::table('payment_vouchers')->where('selectedProject', $project)->select('payment_vouchers.building_name')->distinct()->get();
        return response()->json($index);
    }
    public function getPurchaseByBuilding($building)
    {
        $index = DB::table('payment_vouchers')->where('building_name', $building)->get();
        return response()->json($index);
    }
    public function fetchBuildingFromProjectInventories($project)
    {
        $index = DB::table('inventories')->where('property_project', $project)->select('inventories.building_name')->distinct()->get();
        return response()->json($index);
    }

    public function fethProjectPurchase()
    {
        $index = DB::table('payment_vouchers')->select('payment_vouchers.selectedProject')->where('selectedProject', "!=", "")->where('selectedProject', '!=', 'null')->distinct()->get();
        return response()->json($index);
    }
    public function fetchDashboardProject()
    {
        $index = DB::table('projects')->select('projects.project_name')->get();
        return response()->json($index);
    }
    public function fetchBuildingByProject($project)
    {
        $index = DB::table('inventories')->select('inventories.building_name')->where('property_project', $project)->distinct()->get();
        return response()->json($index);
    }
    public function fethProjectPurchaseManager($name)
    {
        $index = DB::table('manager_approves')->select('manager_approves.project')->where('project', "!=", "")->where('manager_name', $name)->distinct()->get();
        return response()->json($index);
    }

    public function fetchSingleProjectPurchase($project)
    {
        $index = DB::table('payment_vouchers')->where('selectedProject', $project)->get();
        return response()->Json($index);
    }

    public function fetchProjectsJournal()
    {
        $index = DB::table('purchased_journals')->select('purchased_journals.project')->where('due', 0)->where('project', '!=', 'null')->distinct()->get();
        return response()->json($index);
    }

    public  function fetchPurchasedJournal($project)
    {
        $index = DB::table('purchased_journals')->where('project', $project)->where('project', '!=', 'null')->where('due', 0)->get();
        return response()->json($index);
    }

    public function fetchProjectsPayableJournal()
    {
        $index = DB::table('payable_journals')->select('payable_journals.project')->where('project', "!=", "")->where('project', '!=', 'null')->distinct()->get();
        return response()->json($index);
    }

    public function fetchPayableJournalProject($project)
    {
        $index = DB::table('payable_journals')->where('project', $project)->get();
        return response()->json($index);
    }

    public function fetchProjectsReceivableJournal()
    {
        $index = DB::table('receipt_payable_journals')->select('receipt_payable_journals.project')->where('project', "!=", "")->whereNotNull('project')->distinct()->get();
        return response()->json($index);
    }
    public function fetchProjectsReceivableJournalSelect($project)
    {
        $index = DB::table('receipt_payable_journals')->where('project', $project)->get();
        return response()->json($index);
    }

    public function fetchProjectsReceiptJournal()
    {
        $index = DB::table('receipt_journals')->select('receipt_journals.project')->where('project', "!=", "")->where('due', 0)->whereNotNull('project')->distinct()->get();
        return response()->json($index);
    }

    public function fetchProjectsReceiptJournalSelect($project)
    {
        $index = DB::table('receipt_journals')->where('project', $project)->where('due', 0)->get();
        return response()->json($index);
    }

    public function fetchAdminExpense()
    {
        $index = DB::table('expenses')->select('expenses.selectedProject')->distinct()->get();
        return response()->json($index);
    }
    public function fetchAdminExpenseByProject($project)
    {
        $index = DB::table('expenses')->where('selectedProject', $project)->where('selectedProject', '!=', '')->get();
        return response()->json($index);
    }
    public function fetchBuildingByProjects($project)
    {
        $index = DB::table('inventories')->select('inventories.building_name')->where('property_project', $project)->distinct()->get();
        return response()->json($index);
    }
    public function fetchBuildingFromProjectExpense($project)
    {
        $index = DB::table('expenses')->select('expenses.building_name')->where('selectedProject', $project)->distinct()->get();
        return response()->json($index);
    }
    public function pay_construction_voucher($id)
    {

        $index = DB::table('clients')->where('client_id', $id)->first();
        return response()->json($index);
    }
    public function fetchAdminEmployee()
    {
        $index = DB::table('employees')->select('selectedProject')->distinct()->get();
        return response()->json($index);
    }

    public function fetchAdminEmployeeByProject($project)
    {
        $index = DB::table('employees')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function fetchAdminEmployeeByProjectSalary($project)
    {
        $index = DB::table('salaries')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function fetchBuildingEmployee($project)
    {
        $index = DB::table('inventories')->select('inventories.building_name')->where('property_project', $project)->distinct()->get();
        return response()->json($index);
    }
    public function expensebuilding($building_name)
    {
        $index = DB::table('expenses')->where('building_name', $building_name)->get();
        return response()->json($index);
    }
    public function fetchemployeeallbuildings($project)
    {
        $index = DB::table('employees')->where('selectedProject', $project)->select('building_name')->distinct()->get();
        return response()->json($index);
    }
    public function fetchemployeeallbuildingsSalary($project)
    {
        $index = DB::table('salaries')->where('selectedBuilding', $project)->distinct()->get();
        return response()->json($index);
    }
    public function fetchsinglebuildingemployee($building_name)
    {
        $index = DB::table('employees')->where('building_name', $building_name)->distinct()->get();
        return response()->json($index);
    }

    public function fetchInventoryProject()
    {
       
         $index   = DB::table('inventories')->select('property_project')->where('property_project', '!=', '')->distinct()->get();
        return response()->json($index);
    }
    public function fetchBuildingInventory($project)
    {
        $index   = DB::table('buildings')->join('projects',function($join){
            $join->on('buildings.projects_id','projects.id');
        })->where('projects.project_name',$project)->select('building_name')->distinct()->get();
        
        return response()->json($index);
    }
    public function fetchByBuildingClient($building)
    {
        return DB::table('clients')->where('selectedBuilding', $building)->get();
    }
    public function idMaker($building)
    {
        $checkBuildingExist = DB::table('clients')->where('selectedBuilding', $building)->get();
        $last_id = "";
        foreach ($checkBuildingExist as $chk) {
            $last_id = $chk->client_id;
        }

        if ($last_id == '') {
            $counter = 1;
            $lastDigit = sprintf('%03d', $counter);
            return response()->json($lastDigit);
        } else {
            $existing_id = $last_id;
            $split_id = explode('-', $existing_id)[1];
            $split_id = $split_id + 1;
            $lastDigit = sprintf('%03d', $split_id);
            return response()->json($lastDigit);
        }
    }
    public function fetchProjectCode($project)
    {
        return DB::table('projects')->where('project_name', $project)->first();
    }
    public function fetchDataByBuilding($building_name)
    {
        $index   = DB::table('inventories')->where('building_name', $building_name)->distinct()->get();
        return response()->json($index);
    }
    public function fetchDataByProject($project)
    {
        $index   = DB::table('inventories')->where('property_project', $project)->distinct()->get();
        return response()->json($index);
    }
    public function fetch_supplier_history()
    {
        $index = DB::table('payment_histories')->select('payment_id', DB::raw('min(id) as id')) // Replace with the columns you want to retrieve
            ->groupBy('payment_id')
            ->get();
        return response()->json($index);
    }
    public function fetchSalary(Request $request)
    {
        $startdate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('salaries')->select('salaries.*')->whereBetween('basic_date', [$startdate, $enddate])->get();
        //     $totalBalance = 0;
        //    if($index){
        //     foreach($index as $ind){
        //         $totalBalance = $totalBalance+ intval($ind->basic_salary)+ intval($ind->commission);
        //     }
        //    }
        //    $data =[ 'totalSalary'=>$totalBalance];
        return response()->json($index);
    }

    public function searchByEmployee(Request $request)
    {
        $startdate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $enddate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('salaries')->select('salaries.*')->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->where('employee_name', $request->employee_name)->whereBetween('basic_date', [$startdate, $enddate])->get();
        //     $totalBalance = 0;
        //    if($index){
        //     foreach($index as $ind){
        //         $totalBalance = $totalBalance+ intval($ind->basic_salary)+ intval($ind->commission);
        //     }
        //    }
        //    $data =[ 'totalSalary'=>$totalBalance];
        return response()->json($index);
    }

    public function getExpense()
    {
        $totalExpense = 0;
        $index = DB::table('expenses')->get();
        foreach ($index as $ind) {
            $totalExpense += intval($ind->receive_amount);
        }
        return response()->json($totalExpense);
    }

    public function getSalary()
    {
        $totalExpense = 0;
        $index = DB::table('salaries')->get();
        foreach ($index as $ind) {
            $totalExpense += intval($ind->basic_salary) + intval($ind->commission);
        }
        return response()->json($totalExpense);
    }
    public function getManagerPaymentHistory($project)
    {
        $index = DB::table('payment_histories')->where('project', $project)->select('payment_id') // Replace with the columns you want to retrieve
            ->groupBy('payment_id')->get();
        return response()->json($index);
    }
    public function payment_history_view($id)
    {
        $index = DB::table('payment_histories')->where('payment_id', $id)->get();
        return response()->json($index);
    }
    public function payment_history_edit($id)
    {
        $index = DB::table('payment_histories')->where('id', $id)->get();
        return response()->json($index);
    }
    public function delete_history($id)
    {
        $index = DB::table('payment_histories')->where('payment_id', $id)->delete();
        return response()->json($index);
    }
    public function fetch_client_history()
    {
        $index = DB::table('receipt_histories')->select('receipt_id', DB::raw('min(id) as id')) // Replace with the columns you want to retrieve
            ->groupBy('receipt_id')
            ->get();
        return response()->json($index);
    }
    public function getManagerReceiptHistory($project)
    {
        $index = DB::table('receipt_histories')->where('project', $project)->select('receipt_id') // Replace with the columns you want to retrieve
            ->groupBy('receipt_id')->get();
        return response()->json($index);
    }
    public function receipt_history_view($id)
    {
        $index = DB::table('receipt_histories')->where('receipt_id', $id)->get();
        return response()->json($index);
    }
    public function history_receipt(Request $request)
    {
        $paymentHistory = ReceiptHistory::find($request->id);
        $paymentHistory->paid = $request->edit_amount;
        $paymentHistory->save();
        return response()->json($paymentHistory);
    }

    public function delete_receipt($id)
    {
        DB::table('receipt_histories')->where('id', $id)->delete();
    }
    public function deleteFromTotal($id)
    {
        $index = DB::table('advance_pays')->where('id', $id)->first();
        $indexTotal = DB::table('total_advance_pays')->where('client_id', $index->client_id)->first();
        $updateAmount = intval($indexTotal->amount) - intval($index->amount);
        $update = DB::table('total_advance_pays')->where('client_id', $index->client_id)->update(['amount' => $updateAmount]);
        return response()->json($update);
    }
    public function getAdvanceById($id)
    {
        $index = DB::table('advance_pays')->where('id', $id)->first();
        $getIndex = DB::table('advance_pays')->where('client_id', $index->client_id)->get();
        return response()->json($getIndex);
    }

    public function projectFromAdvancePay()
    {
        $index = DB::table('advance_pays')->select('advance_pays.selectedProject')->distinct()->get();
        return response()->json($index);
    }
    public function advancePaysSelectedProject($project)
    {
        $index = DB::table('advance_pays')->where('selectedProject', $project)->get();
        return response()->json($index);
    }
    public function advancePaysFetchAllBuildings($project)
    {
        $index = DB::table('advance_pays')->select('advance_pays.selectedBuilding')->where('selectedProject', $project)->distinct()->get();
        return response()->json($index);
    }
    public function advancePaysFetchByBuildings($building)
    {
        $index = DB::table('advance_pays')->where('selectedBuilding', $building)->get();
        return response()->json($index);
    }
    public function fetchAdvanceByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('advance_pays')->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchAdvanceInVoucher(Request $request)
    {
        $index = DB::table('advance_pays')->where('client_id', $request->client_id)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->first();
        return response()->json($index);
    }
    public function updatedAdvance(Request $request)
    {
        $advance_pays = DB::table('advance_pays')->where('client_id', $request->client_id)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->first();
        $updatedAmount = intval($advance_pays->amount) - intval($request->product_amount);
        DB::table('advance_pays')->where('id', $advance_pays->id)->update(['amount' => $updatedAmount]);
        $totalAdvance = DB::table('total_advance_pays')->where('client_id', $request->client_id)->first();
        $updateTotalAmount = intval($totalAdvance->amount) - intval($request->product_amount);
        DB::table('total_advance_pays')->where('client_id', $request->client_id)->update(['amount' => $updateTotalAmount]);
    }
    public function deleteInAdvance(Request $request)
    {
        $advance_pays = DB::table('advance_pays')->where('client_id', $request->client_id)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->first();
        $totalAdvance = DB::table('total_advance_pays')->where('client_id', $request->client_id)->first();
        $updatedAmount = intval($totalAdvance->amount) - intval($request->advance_amount);
        DB::table('total_advance_pays')->where('client_id', $request->client_id)->update(['amount' => $updatedAmount]);

        DB::table('advance_pays')->where('id', $advance_pays->id)->delete();
    }
    public function fetchClientByProject($project)
    {
        $index = DB::table('clients')->where('clientUnderProject', $project)->distinct()->get();
        return response()->json($index);
    }
    public function projectFromConstruction()
    {
        $index = DB::table('construction_requireds')->select('selectedProject')->groupBy('selectedProject')->get();
        return response()->json($index);
    }

    public function getMergeGroup($construction_id)
    {
        $collection = DB::table('construction_requireds')->join('clients','construction_requireds.client_id','=','clients.client_id')->where('construction_id', $construction_id)->select('construction_requireds.*','clients.phone')->get();
        $data = $collection->map(function ($item) {
            $fees = DB::table('construction_requireds')->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->sum('required_amount');
            $pays = DB::table('construction_pays')->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->sum('paid_amount');
            if (!$pays) {
                $item->due = $fees;
                return $item;
            } else if ($fees > $pays) {
                $item->due = $fees - $pays;
                return $item;
            }
        })->filter()->values()->toArray();

        return response()->json($collection);
    }
    public function constructionSelectedProject1($project){
        $index = DB::table('construction_requireds')->where('selectedProject',$project)->where('select_type','all')->select(
            DB::raw('MIN(id) as id'),
            DB::raw('MIN(basic_date) as basic_date'),
            DB::raw('MIN(construction_id) as construction_id'),
            DB::raw('MIN(selectedProject) as selectedProject'),
            DB::raw('MIN(selectedBuilding) as selectedBuilding'),
            DB::raw('MIN(note) as note'),
            DB::raw('SUM(required_amount) as required_amount'),
            DB::raw('MIN(due_date) as due_date'),
        )->groupBy('selectedProject','selectedBuilding')->get();
        return response()->json($index);
    }
    public function constructionFetchByBuildings1($building){
        $index = DB::table('construction_requireds')->where('selectedBuilding',$building)->where('select_type','all')->select(
            DB::raw('MIN(id) as id'),
            DB::raw('MIN(basic_date) as basic_date'),
            DB::raw('MIN(construction_id) as construction_id'),
            DB::raw('MIN(selectedProject) as selectedProject'),
            DB::raw('MIN(selectedBuilding) as selectedBuilding'),
            DB::raw('MIN(note) as note'),
            DB::raw('SUM(required_amount) as required_amount'),
            DB::raw('MIN(due_date) as due_date'),
        )->groupBy('selectedBuilding')->get();
        return response()->json($index);
    }
    public function constructionSelectedProject($project)
    {

        $index = DB::table('construction_requireds')->where('selectedProject', $project)->where('select_type', 'one')
            ->get();
        $data = $index->map(function ($item) {
            $pays = DB::table('construction_pays')->where('selectedProject', $item->selectedProject)->where('selectedBuilding', $item->selectedBuilding)->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->sum('paid_amount');
            if (!$pays) {
                $item->due = $item->required_amount;
                return $item;
            } else if ($item->required_amount > $pays) {
                $item->due = $item->required_amount - $pays;
                return $item;
            }
        })->filter()->values()->toArray();
        return response()->json($data);
    }
    public function constructionSelectedProjectPay($project)
    {
        $index = DB::table('construction_pays')->where('selectedProject', $project)->get();
        return response()->json($index);
    }

    public function constructionSelectedBuilding($project)
    {
        $index = DB::table('construction_requireds')->select('selectedBuilding')->where('selectedProject', $project)->groupBy('selectedBuilding')->get();
        return response()->json($index);
    }
    public function constructionSelectedBuildingPay($project)
    {
        $index = DB::table('construction_pays')->select('selectedBuilding')->where('selectedProject', $project)->groupBy('selectedBuilding')->get();
        return response()->json($index);
    }
    public function constructionFetchByBuildings($building)
    {
        $index = DB::table('construction_requireds')->where('selectedBuilding', $building)->where('select_type', 'one')
            ->get();
        $data = $index->map(function ($item) use ($building) {
            $paidData = DB::table('construction_pays')->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->where('selectedProject', $item->selectedProject)->where('selectedBuilding', $building)->sum('paid_amount');
            if (!$paidData) {
                $item->due = $item->required_amount;
                return $item;
            } else if ($item->required_amount > $paidData) {
                $item->due = $item->required_amount - $paidData;
                return $item;
            }
        })->filter()->values()->toArray();
        return response()->json($data);
    }
    public function delete_merge_construction($id)
    {
        DB::table('construction_pays')->where('construction_id', $id)->delete();
        DB::table('construction_requireds')->where('construction_id', $id)->delete();
    }
    public function view_merge_construction($id)
    {
        $index = DB::table('construction_requireds')->where('construction_id', $id)->get();
        return response()->json($index);
    }
    public function constructionFetchByBuildingsPay($building)
    {
        $index = DB::table('construction_pays')->where('selectedBuilding', $building)->get();
        return response()->json($index);
    }
    public function fetchConstructionByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('construction_requireds')->whereBetween('basic_date', [$startDate, $endDate])
        ->where('select_type','all')->select(
            DB::raw('MIN(id) as id'),
            DB::raw('MIN(basic_date) as basic_date'),
            DB::raw('MIN(construction_id) as construction_id'),
            DB::raw('MIN(selectedProject) as selectedProject'),
            DB::raw('MIN(selectedBuilding) as selectedBuilding'),
            DB::raw('MIN(note) as note'),
            DB::raw('SUM(required_amount) as required_amount'),
            DB::raw('MIN(due_date) as due_date'),
        )
        ->get();
        $data = $index->map(function ($item) {
            $pays = DB::table('construction_pays')->where('selectedProject', $item->selectedProject)->where('selectedBuilding', $item->selectedBuilding)->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->sum('paid_amount');
            if (!$pays) {
                $item->due = $item->required_amount;
                return $item;
            } else if ($item->required_amount > $pays) {
                $item->due = $item->required_amount - $pays;
                return $item;
            }
        })->filter()->values()->toArray();
        return response()->json($data);
    }

    public function fetchPayConstructionByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('construction_pays')->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchReceiptVoucherByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('receipt_vouchers')->where('selectedProject', $request->selectedProject)->where('building_name', $request->selectedBuilding)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchPaymentVoucherByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('payment_vouchers')->where('selectedProject', $request->selectedProject)->where('building_name', $request->selectedBuilding)->where('product_name', $request->selectedProduct)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchBuildlingsInPurchaseJournal($project)
    {
        return DB::table('purchased_journals')->where('project', $project)->select('purchased_journals.building_name')->distinct()->get();
    }
    public function getBuildingInPayable($project)
    {
        return DB::table('payable_journals')->where('project', $project)->select('payable_journals.building_name')->distinct()->get();
    }
    public function getPayableByBuilding($building)
    {
        return DB::table('payable_journals')->where('building_name', $building)->get();
    }
    public function fetchBuildingInReceivable($project)
    {
        return DB::table('receipt_payable_journals')->where('project', $project)->select('receipt_payable_journals.building_name')->distinct()->get();
    }
    public function fetchReceivableByBuilding($building)
    {
        return DB::table('receipt_payable_journals')->where('building_name', $building)->get();
    }
    public function fetchBuildingByProjectInStock($project)
    {
        return DB::table('inventories')->where('property_project', $project)->select('inventories.building_name')->distinct()->get();
    }
    public function getTransferedQuantity(Request $request)
    {
        return DB::table('stocks')->where('project', $request->fromProject)->where('selectedBuilding', $request->fromBuilding)->where('product_name', $request->product_name)->select('stocks.quantity')->first();
    }
    public function fetchAllProjectFromStock()
    {
        return DB::table('consume_stocks')->where('selectedProject', '!=', '')->select('consume_stocks.selectedProject')->distinct()->get();
    }
    public function fetchStockByProject($project)
    {
        return DB::table('consume_stocks')->where('selectedProject', $project)->get();
    }
    public function fetchBuildingInStock($project)
    {
        return DB::table('consume_stocks')->where('selectedProject', $project)->select('consume_stocks.building_name')->get();
    }
    public function fetchStockByBuilding($building)
    {
        return DB::table('consume_stocks')->where('building_name', $building)->get();
    }
    public function fetchByBuildlingsInPurchaseJournal($building)
    {
        return DB::table('purchased_journals')->where('building_name', $building)->where('due', '=', 0)->get();
    }
    public function fetchBuildingInReceiptJournal($project)
    {
        return DB::table('receipt_journals')->where('project', $project)->select('receipt_journals.building_name')->distinct()->get();
    }
    public function fetchReceiptJournalByBuildingName($building)
    {
        return DB::table('receipt_journals')->where('building_name', $building)->where('due', "=", 0)->get();
    }
    public function getProductByBuilding($building)
    {
        $index = DB::table('payment_vouchers')->where('building_name', $building)->select('payment_vouchers.product_name')->distinct()->get();
        return response()->json($index);
    }
    public function getProductByProject($building)
    {
        $index = DB::table('payment_vouchers')->where('selectedProject', $building)->select('payment_vouchers.product_name')->distinct()->get();
        return response()->json($index);
    }
    public function getDataByProduct($product)
    {
        $index = DB::table('payment_vouchers')->where('product_name', $product)->get();
        return response()->json($index);
    }

    public function fetchAllExpenseByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('expenses')->where('selectedProject', $request->selectedProject)->where('building_name', $request->selectedBuilding)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }

    public function fetch_paid_construction(Request $request)
    {
        $data = DB::table('construction_pays')->where('client_id', $request->client_id)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->get();
        return response()->json($data);
    }

    public function clientBaseSearchAdvance(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('advance_pays')->where('selectedProject', $request->project)->where('selectedBuilding', $request->building)->where('client_id', $request->client)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }

    public function clientBaseSearchRequiredConstruction(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('construction_requireds')->where(function ($query) use ($request) {
            $query->where('selectedProject', $request->project)->orWhere('selectedBuilding', $request->building)->orWhere('client_name', $request->client);
        })->whereBetween('basic_date', [$startDate, $endDate])->get();

        $data = $index->map(function ($item) {
            $pays = DB::table('construction_pays')->where('selectedProject', $item->selectedProject)->where('selectedBuilding', $item->selectedBuilding)->where('construction_id', $item->construction_id)->where('client_id', $item->client_id)->sum('paid_amount');
            if (!$pays) {
                $item->due = $item->required_amount;
                return $item;
            } else if ($item->required_amount > $pays) {
                $item->due = $item->required_amount - $pays;
                return $item;
            }
        })->filter()->values()->toArray();
        return response()->json($data);
    }

    public function clientBaseSearchAdvanceManager($client)
    {
        $index = DB::table('advance_pays')->where('client_id', $client)->get();
        return response()->json($index);
    }
    public function clientBaseSearchRequiredConstructionManager(Request $request)
    {
        $index = DB::table('construction_requireds')->where('client_name', $request->client)->get();

        $client_info =  $index->map(function ($client_item) use ($request) {
            $projects = DB::table('manager_approves')->where('manager_name', $request->manager)->get();
            foreach ($projects as $project_item) {
                if ($project_item->project == $client_item->selectedProject) {
                    return $client_item;
                }
            }
        });
        $data = $client_info->map(function ($item) {
            $pays = DB::table('construction_pays')->where('client_name', $item->client_name)->sum('paid_amount');
            if (!$pays) {
                $item->due = $item->required_amount;
                return $item;
            } else if ($item->required_amount > $pays) {
                $item->due = $item->required_amount - $pays;
                return $item;
            }
        })->filter()->values()->toArray();
        return response()->json($data);
    }
    public function getBuildingByPropertyProject($project)
    {
        $data = DB::table('projects')->where('project_name', $project)->first();
        $building = DB::table('buildings')->where('projects_id', $data->id)->select('building_name')->groupBy('building_name')->get();
        return response()->json($building);
    }
    public function clientBaseSearcPayConstruction(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('construction_pays')->where('selectedProject', $request->project)->where('selectedBuilding', $request->building)->where('client_name', $request->client)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function clientBaseSearcPayConstructionManager($client)
    {
        $index = DB::table('construction_requireds')->where('client_name', $client)->get();
        return response()->json($index);
    }
    public function fetch_sales_project()
    {
        return DB::table('inventories')->where('property_type', 'Building')->select('property_project')->groupBy('property_project')->get();
    }
    public function fetch_sales_project_manager($project)
    {
        return DB::table('inventories')->where('property_type', 'Building')->where('property_project', $project)->select('project')->groupBy('property_project')->get();
    }
    public function fetch_sales_building($project)
    {
        return DB::table('inventories')->where('property_type', 'Building')->where('property_project', $project)->select('building_name')->groupBy('building_name')->get();
    }

    public function productBaseSearchExpense(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('expenses')->where('selectedProject', $request->project)->where('building_name', $request->building)->where('product_name', $request->product_name)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function productBaseSearchExpenseManager(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('expenses')->where('selectedProject', $request->project)->where('building_name', $request->building)->where('product_name', $request->product_name)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }

    public function receiptBaseSearchExpense(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('receipt_vouchers')->where('selectedProject', $request->project)->where('building_name', $request->building)->where('client_name', $request->client_name)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function receiptBaseSearchExpenseManager($client_name)
    {
        $index = DB::table('receipt_vouchers')->where('client_name', $client_name)->get();
        return response()->json($index);
    }
    //

    public function paymentBaseSearchExpense(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('payment_vouchers')->where('selectedProject', $request->project)->where('building_name', $request->building)->where('payee_name', $request->client_name)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function paymentBaseSearchExpenseManager(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('payment_vouchers')->where('payee_name', $request->client_name)->where('selectedProject', $request->project)->where('building_name', $request->building)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function paymentBaseSearchExpenseLedger(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('payment_vouchers')->where('selectedProject', $request->project)->where('building_name', $request->building)->where('ledger_no', $request->client_name)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function paymentBaseSearchExpenseManagerLedger(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('payment_vouchers')->where('ledger_no', $request->client_name)->where('selectedProject', $request->project)->where('building_name', $request->building)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }

    public function fetchStockJournalByDate(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('consume_stocks')->where('selectedProject', $request->selectedProject)->where('building_name', $request->selectedBuilding)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchStockJournalByDateTransfer(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('stock_transfers')->where('fromProject', $request->selectedFromProject)->where('fromBuilding', $request->selectedFromBuilding)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }

    public function fetchStockJournalByDateProductTransfer(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('stock_transfers')->where('fromProject', $request->selectedFromProject)->where('fromBuilding', $request->selectedFromBuilding)->where('selectedProject', $request->selectedProject)->where('selectedBuilding', $request->selectedBuilding)->where('product_name', $request->product)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function fetchStockJournalByDateProduct(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('consume_stocks')->where('selectedProject', $request->selectedProject)->where('building_name', $request->selectedBuilding)->where('product_name', $request->product)->whereBetween('basic_date', [$startDate, $endDate])->get();
        return response()->json($index);
    }
    public function pay_construction_merge(Request $request)
    {
        $count = DB::table('construction_requireds')->where('construction_id', $request->construction_id)->get();
        foreach ($count as $ct) {
            $construction = new ConstructionPay;
            $construction->basic_date = $request->basic_date;
            $construction->client_name = $ct->client_name;
            $construction->client_id = $ct->client_id;
            $construction->selectedProject = $ct->selectedProject;
            $construction->selectedBuilding = $ct->selectedBuilding;
            $construction->paid_amount = $request->paid_amount;
            $construction->note = $request->note;
            $construction->construction_id = $request->construction_id;
            $construction->save();
            $totalPay = 0;
            $pays = DB::table('construction_pays')->where('client_id', $ct->client_id)->where('selectedProject', $ct->selectedProject)->where('selectedBuilding', $ct->selectedBuilding)->get();
            if ($pays) {
                foreach ($pays as $pay) {
                    $totalPay += intval($pay->paid_amount);
                }
            }
            $required = DB::table('construction_requireds')->where('client_id', $ct->client_id)->where('selectedProject', $ct->selectedProject)->where('selectedBuilding', $ct->selectedBuilding)->first();
            if (intval($totalPay) > intval($required->required_amount)) {
                $extra_amount = intval($totalPay) - intval($required->required_amount);
                $paid_amount = intval($totalPay);
                $due_amount = 0;
                DB::table('construction_requireds')->where('client_id', $ct->client_id)->where('selectedProject', $ct->selectedProject)->where('selectedBuilding', $ct->selectedBuilding)->update(['paid_amount' => $paid_amount, 'extra_amount' => $extra_amount, 'due_amount' => $due_amount]);
            } else {
                $extra_amount = 0;
                $paid_amount = intval($totalPay);
                $due_amount =  intval($required->required_amount) - intval($totalPay);
                DB::table('construction_requireds')->where('client_id', $ct->client_id)->where('selectedProject', $ct->selectedProject)->where('selectedBuilding', $ct->selectedBuilding)->update(['paid_amount' => $paid_amount, 'extra_amount' => $extra_amount, 'due_amount' => $due_amount]);
            }
        }
    }
    public function construction_merge($id){
        $data = DB::table('construction_requireds')->where('construction_id',$id)->first();
        return response()->json($data);
    }
    public function edit_merge_construction(Request $request, $id)
    {
        $getconstruction = ConstructionRequired::where('construction_id', $id)->get();
        foreach ($getconstruction as $cl) {
            $construction =  ConstructionRequired::find($cl['id']);
            $construction->basic_date = $request->basic_date;
            $construction->selectedProject = $request->selectedProject;
            $construction->selectedBuilding = $request->selectedBuilding;
            $construction->required_amount = $request->required_amount;
            $construction->paid_amount = 0;
            $construction->due_amount = $request->required_amount;
            $construction->extra_amount = 0;
            $construction->due_date = $request->due_date;

            $construction->save();
        }
    }

    public function totalClient()
    {
        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }

    public function totalSupplier()
    {
        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalEmployee()
    {
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }
    //by day
    public function totalDailyClient()
    {
        $startDate =  Carbon::now()->format('Y-m-d');
        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->where('created_at', $startDate)->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }

    public function totalDailySupplier()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->where('created_at', $startDate)->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalDailyEmployee()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->where('created_at', $startDate)->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }


    //weekly
    public function totalWeeklyClient()
    {
        $startDate =  Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->subDays('7')->format('Y-m-d');

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->whereBetween('created_at', [$endDate, $startDate])->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalWeeklySupplier()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->subDays('7')->format('Y-m-d');

        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->whereBetween('created_at', [$endDate, $startDate])->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalWeeklyEmployee()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->subDays('7')->format('Y-m-d');
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->whereBetween('created_at', [$endDate, $startDate])->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }

    //monthly
    //weekly
    public function totalMonthlyClient()
    {
        $startDate =  Carbon::now()->startOfMonth()->format('Y-m-d');
        $endDate = Carbon::now()->endOfMonth()->format('Y-m-d');

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalMonthlySupplier()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->subDays('7')->format('Y-m-d');

        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalMonthlyEmployee()
    {
        $startDate = Carbon::now()->format('Y-m-d');
        $endDate = Carbon::now()->subDays('7')->format('Y-m-d');
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }
    //yearly
    public function totalYearlyClient()
    {
        $startDate =  Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalYearlySupplier()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');

        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalYearlyEmployee()
    {
        $startDate = Carbon::now()->startOfYear()->format('Y-m-d');
        $endDate = Carbon::now()->endOfYear()->format('Y-m-d');
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }
    //date range
    public function totalDateClient(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalDateSupplier(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);

        $index = DB::table('suppliers')->select('suppliers.supplier_id', DB::raw('Min(supplier_id) as supplier_id'))->groupBy('supplier_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalDateEmployee(Request $request)
    {
        $startDate = Carbon::createFromFormat('Y-m-d', $request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d', $request->endDate);
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->whereBetween('created_at', [$startDate, $endDate])->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }
    //project
    public function totalProjectClient($project)
    {

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->where('clientUnderProject', $project)->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalProjectSupplier($project)
    {

        $index = DB::table('payment_vouchers')->select('payment_vouchers.payee_name', DB::raw('Min(payee_name) as payee_name'))->groupBy('payee_name')->where('selectedProject', $project)->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalProjectEmployee($project)
    {
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->where('selectedProject', $project)->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }

    //building
    public function totalBuildingClient($project)
    {

        $index = DB::table('clients')->select('clients.client_id', DB::raw('Min(client_id) as client_id'))->groupBy('client_id')->where('selectedBuilding', $project)->get();
        $totalClient = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalClient += 1;
            }
        }
        return response()->json($totalClient);
    }
    public function totalBuildingSupplier($project)
    {

        $index = DB::table('payment_vouchers')->select('payment_vouchers.payee_name', DB::raw('Min(payee_name) as payee_name'))->groupBy('payee_name')->where('building_name', $project)->get();
        $totalSupplier = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalSupplier += 1;
            }
        }
        return response()->json($totalSupplier);
    }

    public function totalBuildingEmployee($project)
    {
        $index = DB::table('employees')->select('employees.employee_id', DB::raw('Min(employee_id) as employee_id'))->groupBy('employee_id')->where('building_name', $project)->get();
        $totalEmployee = 0;
        if ($index) {
            foreach ($index as $ind) {
                $totalEmployee += 1;
            }
        }
        return response()->json($totalEmployee);
    }


    public function get_building_data($id)
    {
        return DB::table('buildings')->where('projects_id', $id)->get();
    }

    public function get_client_project($id)
    {
        return DB::table('clients')->where('id', $id)->first();
    }
    public function get_client_project_building($project)
    {
        return DB::table('buildings')->join('projects', function ($join) use ($project) {
            $join->on('buildings.projects_id', '=', 'projects.id')->where('projects.project_name', $project);
        })->select('buildings.building_name')->groupBy('building_name')->get();
    }
    public function fetch_client_property_name($building_name)
    {
        return DB::table('inventories')->where('building_name', $building_name)->where('property_status', 'Available')->get();
    }

    public function fill_voucher_by_property(Request $request, $id)
    {
        $data = $request->all();
        $phone = DB::table('clients')->where('client_id',$id)->select('phone')->first();    

        $checkEmptyReceipt = DB::table('receipt_vouchers')->where('client_id', $id)->where('product_name', 'Not Selected')->count();
        $info = DB::table('receipt_vouchers')->where('client_id', $id)->where('product_name', 'Not Selected')->get();
        for ($i = 0; $i < $checkEmptyReceipt; $i++) {
             $product_name = 'Not-Selected';
             $name = $data[$i]['property_name'];
             //update construction property 
             $con=DB::table('construction_requireds')->where('client_id',$id)->where('property_name',"")->first();
             if($con){
                DB::table('construction_requireds')->where('id',$con->id)->update(['property_name'=>$name]);
             }
            $product_amount = $data[$i]['property_amount'];
            $property_id = $data[$i]['property_id'];
            $amount = $info[$i]->product_amount;
            $sub_property_id = $data[$i]['sub_property_id'];
            DB::table('receipt_vouchers')->where('client_id', $id)->where('product_name', 'Not Selected')->update([
                'product_name'=>$product_name,
                // 'product_amount' => $product_amount,
                'property_id' => $property_id,
                'sub_property_id' => $sub_property_id,
                // 'due' => intval($product_amount) - intval($amount)
            ]);
          
            DB::table('inventories')->where('sub_property_id', $data[$i]['sub_property_id'])->where('property_name', $data[$i]['property_name'])->first();
         
          
            DB::table('inventories')->where('sub_property_id', $data[$i]['sub_property_id'])->where('property_name', $data[$i]['property_name'])->update([
                'property_status' => 'Sold',
                'owner' => $info[$i]->client_name,
                'receipt_id' => $info[$i]->receipt_id,
                'client_id'=>$id,
                'phone'=>$phone->phone,
            ]);
           
           
           
        }
       
        $dataLength = count($data);
       
        if($checkEmptyReceipt>$dataLength){
            DB::table('clients')->where('client_id',$id)->update(['share'=>$checkEmptyReceipt]);
        }
     
      
    }


 public function deleteUnit($id){
    DB::table('units')->where('id',$id)->delete();
 }

public function checkSold($id){
    $data = DB::table('inventories')->where('id',$id)->first();
    return response()->json($data);
}

public function showClientByBuilding($building){
    $data = DB::table('clients')->where('selectedBuilding',$building)->get();
    return response()->json($data);
}
public function fetch_client_construction($id){
    $data = DB::table('construction_requireds')->where('client_id',$id)->
        select(DB::raw('MIN(id) as id'),DB::raw('MIN(client_name) as client_name'),DB::raw('MIN(client_id) as client_id'),DB::raw('GrOUP_CONCAT(property_name) as property_name'),DB::raw('MIN(required_amount) as required_amount'),DB::raw('MIN(paid_amount) as paid_amount'),DB::raw('MIN(due_amount) as due_amount'),DB::raw('MIN(extra_amount) as extra_amount'),DB::raw('MIN(share) as share'))->groupBy('client_id')->get();
    return response()->json($data);
    }












}
