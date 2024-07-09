<template>
  <ul
    class="navbar-nav sidebar sidebar-dark accordion"
    :class="{ sidemenuChange: sideMenu }"
    id="accordionSidebar"
    v-show="!hideRegisterLogin"
  >
    <!-- bg-gradient-primary -->
    <div
      class="logo_container sidebar-brand d-flex align-items-center justify-content-center"
    >
      <div class="sidebar-brand-icon">
        <img class="logo" :src="'../img/' + logo" alt="" />
      </div>
    </div>
    <!-- Sidebar - Brand -->
    <div class="sidebar-brand d-flex align-items-center justify-content-center">
      <div class="sidebar-brand-icon rotate-n-15"></div>
      <div class="sidebar-brand-text mx-3">HKF Control Panel</div>
    </div>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" />
    <div class="dashboard-lists">
      <!-- Nav Item - Dashboard -->
      <li class="nav-item active" style="background: #605ca8">
        <router-link
          class="nav-link"
          :to="{ name: 'admin_dashboard' }"
          :class="{ collapse_link: sideMenu }"
        >
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span></router-link
        >
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">Interface</div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#admininistrator"
          aria-expanded="true"
          aria-controls="admininistrator"
        >
          <i class="fa fa-user"></i>
          <span>Administrator</span>
        </a>
        <div
          id="admininistrator"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'unit' }"
              >Units
            </router-link>
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_category' }"
              >Product Categories</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'late_fine' }"
              >Late Fine Details</router-link
            >
          </div>
        </div>
      </li>
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#project"
          aria-expanded="true"
          aria-controls="project"
        >
          <i class="fas fa-folder-minus"></i>
          <span>Project Control</span>
        </a>
        <div
          id="project"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'add_project' }"
              >Add Project</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_project' }"
              >All Project</router-link
            >
          </div>
        </div>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#clients"
          aria-expanded="true"
          aria-controls="clients"
        >
          <i class="fa fa-users"></i>
          <span>Client</span>
        </a>
        <div
          id="clients"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'add_client' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Add Client</router-link
            >
            <router-link
              :to="{ name: 'all_client' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >All Client</router-link
            >
          </div>
        </div>
      </li>
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#Salary"
          aria-expanded="true"
          aria-controls="Salary"
        >
          <i class="fas fa-users"></i>
          <span>Employee</span>
        </a>
        <div
          id="Salary"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'add_employee' }"
              >Add Employee</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_employee' }"
              >All Employee</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'salary_sheet' }"
              >Salary Sheet</router-link
            >
          </div>
        </div>
      </li>

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#suppliers"
          aria-expanded="true"
          aria-controls="suppliers"
        >
          <i class="fa fa-users"></i>
          <span>Supplier</span>
        </a>
        <div
          id="suppliers"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'add_supplier' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Add Supplier</router-link
            >
            <router-link
              :to="{ name: 'all_supplier' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >All Supplier</router-link
            >
          </div>
        </div>
      </li>
      <!-- payment-->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#purchase"
          aria-expanded="true"
          aria-controls="purchase"
        >
          <i class="fas fa-fw fa-book"></i>
          <span>Purchase</span>
        </a>
        <div
          id="purchase"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'payment_all_voucher' }"
            >
              Payment Voucher</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'purchase_journal' }"
            >
              Purchase Journal</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'accounts_payable' }"
            >
              Accounts Payable</router-link
            >

            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'pay_payable' }"
            >
              Pay Due</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'payment_history' }"
            >
              Payment History</router-link
            >

            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'purchase_return' }"
            >
              Purchase Return</router-link
            >

            <!-- <router-link class="collapse-item" :class="{collapse_Font:sideMenu}" :to="{name:'ledger'}"> Ledger</router-link>
            <router-link class="collapse-item" :class="{collapse_Font:sideMenu}" :to="{name:'ledger'}"> Ledger</router-link> -->
          </div>
        </div>
      </li>
      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#accounts"
          aria-expanded="true"
          aria-controls="accounts"
        >
          <i class="fas fa-fw fa-book"></i>
          <span>Sales Receipt</span>
        </a>
        <div
          id="accounts"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'receipt_voucher' }"
              >Create Receipt Voucher</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_voucher' }"
            >
              Receipt Voucher</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'sales_journal' }"
            >
              Sales Journal</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'accounts_receivable' }"
            >
              Accounts Receivable</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'pay_receivable' }"
            >
              Receipt Due</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'receipt_history' }"
            >
              Receipt History</router-link
            >
            <hr />

            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'ledger' }"
            >
              Ledger</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'trial_balance' }"
            >
              Trial Balance</router-link
            >
            <!-- <router-link class="collapse-item" :class="{collapse_Font:sideMenu}" :to="{name:'ledger'}"> Ledger</router-link>
            <router-link class="collapse-item" :class="{collapse_Font:sideMenu}" :to="{name:'ledger'}"> Ledger</router-link> -->
          </div>
        </div>
      </li>
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#Expense"
          aria-expanded="true"
          aria-controls="Expense"
        >
          <i class="fas fa-dollar-sign"></i>
          <span>Expense</span>
        </a>
        <div
          id="Expense"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'add_expense' }"
              >Add Expense</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_expense' }"
              >All Expense</router-link
            >
          </div>
        </div>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider" />

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#advance"
          aria-expanded="true"
          aria-controls="advance"
        >
          <i class="fas fa-folder-minus"></i>
          <span>Extra Payment (Flat/Land)</span>
        </a>
        <div
          id="advance"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'advance_pay' }"
              >Add Extra Pay
            </router-link>
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_advance_pay' }"
            >
              Extra Pay Lists</router-link
            >
          </div>
        </div>
      </li>

      <hr class="sidebar-divider" />

      <!--Salary -->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          data-toggle="collapse"
          data-target="#Requisition"
          href="#"
          aria-expanded="true"
          aria-controls="Requisition"
        >
          <span>Stock Valuation</span>
        </a>
        <div
          id="Requisition"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'add_stock_journal' }"
              >Add Stock Consumption
            </router-link>
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_stock_journal' }"
              >Stock Consumption Lists</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'view_stock_journal' }"
              >Stocks</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_stock_transfer' }"
              >Stock Transfer</router-link
            >
          </div>
        </div>
      </li>

      <!-- Expense-->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#construction"
          aria-expanded="true"
          aria-controls="construction"
        >
          <i class="fas fa-folder-minus"></i>
          <span>Construction</span>
        </a>
        <div
          id="construction"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'required_construction' }"
              >Add Construction Cost
            </router-link>
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_required_construction' }"
            >
              All Construction Cost</router-link
            >

            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'all_pay_construction' }"
            >
              Paid Construction Cost</router-link
            >
            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'construction_project_list' }"
            >
              Project Base Report</router-link
            >

            <router-link
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              :to="{ name: 'construction_building_list' }"
            >
              Building Base Report</router-link
            >
          </div>
        </div>
      </li>
      <!-- inventory-->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#sales"
          aria-expanded="true"
          aria-controls="sales"
        >
          <i class="fas fa-comment-dollar"></i>
          <span>Sales</span>
        </a>
        <div
          id="sales"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'create_sales' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Create Sales(Land)</router-link
            >
            <router-link
              :to="{ name: 'create_sales_building' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Create Sales(Building)</router-link
            >
            <router-link
              :to="{ name: 'sales_project' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Sales Building</router-link
            >
            <router-link
              :to="{ name: 'all_sales' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >Inventories</router-link
            >
          </div>
        </div>
      </li>
      <!-- purchase land-->
      <li class="nav-item">
        <router-link
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          :to="{ name: 'add_purchase_land' }"
          data-toggle="collapse"
          data-target="#PurchaseLandDetails"
          aria-expanded="true"
          aria-controls="PurchaseLandDetails"
        >
          <i class="fas fa-home"></i>
          <span>Purchase Land Details</span>
        </router-link>
      </li>
      <!-- Member-->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#member"
          aria-expanded="true"
          aria-controls="member"
        >
          <span>(Flat Land) Sales Report</span>
        </a>
        <div
          id="member"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'project_lists' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >Project Base Report</router-link
            >

            <router-link
              :to="{ name: 'building_lists' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >Building Base Report</router-link
            >
          </div>
        </div>
      </li>
      <!-- Reference-->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#reference"
          aria-expanded="true"
          aria-controls="reference"
        >
          <span>Reference</span>
        </a>
        <div
          id="reference"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'add_reference' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Create Reference</router-link
            >
            <router-link
              :to="{ name: 'all_reference' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >All Reference</router-link
            >
          </div>
        </div>
      </li>
      <!-- Manager -->

      <li class="nav-item">
        <a
          class="nav-link collapsed"
          :class="{ collapse_link: sideMenu }"
          href="#"
          data-toggle="collapse"
          data-target="#manager"
          aria-expanded="true"
          aria-controls="manager"
        >
          <span>Manager Approval</span>
        </a>
        <div
          id="manager"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="sub_menu py-2 collapse-inner rounded">
            <router-link
              :to="{ name: 'add_manager_approve' }"
              :class="{ collapse_Font: sideMenu }"
              class="collapse-item"
              >Project Registration</router-link
            >
            <router-link
              :to="{ name: 'all_manager_approve' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >All Registered</router-link
            >
            <router-link
              :to="{ name: 'delete_manager' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >Manager Resignation</router-link
            >
            <router-link
              :to="{ name: 'accounts_access' }"
              class="collapse-item"
              :class="{ collapse_Font: sideMenu }"
              >Accounts Access</router-link
            >
          </div>
        </div>
      </li>

      <!-- Nav Item - Charts -->

      <!-- Nav Item - Tables -->
    </div>
    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block" />

    <!-- Sidebar Toggler (Sidebar) -->
    <!-- <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div> -->

    <!-- Sidebar Message -->
  </ul>
</template>
<script>
export default {
  name: "sidebar",
  data() {
    return {
      registerRoute: true,
      logo: "logo.png",
    };
  },
  props: {
    sideMenu: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
    hideRegisterLogin() {
      return (
        this.$route.path === "/admin/register" ||
        this.$route.path === "/admin/login" ||
        this.$route.path === "/manager/register" ||
        this.$route.path === "/manager/login" ||
        this.$route.path === "/" ||
        this.$route.path === "/:catchAll(.*)"
      );
    },
  },
};
</script>
<style>
.sidemenuChange {
  width: 11rem !important;
}
.collapse_Font {
  font-size: 0.8em;
  width: 9rem !important;
}
.collapse_link {
  width: 11rem !important;
}
.logo {
  background-size: cover;
  width: 100%;
  height: 100%;
  margin-top: 2em;
  margin-bottom: 2em;
}
.logo_container {
  height: 115px !important;
}
</style>
