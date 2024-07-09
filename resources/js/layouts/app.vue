<template>
  <!-- sidebar-->

  <div id="wrapper" v-if="authenticatedRoutes($route.name)">
    <!-- Sidebar -->
    <Assetloader />
    <SidebarComponent :sideMenu="clicked" v-if="admin_sidebar"></SidebarComponent>
    <SidebarManagerComponent
      :sideMenu="clicked"
      v-else-if="manager_sidebar"
    ></SidebarManagerComponent>

    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <!-- Main Content -->
      <div id="content">
        <!-- Topbar -->
        <NavComponent
          @toggleButton="forSidebar"
          v-show="admin_sidebar || manager_sidebar"
        ></NavComponent>

        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid" :class="containerDynamic">
          <!-- Page Heading -->
          <router-view></router-view>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
      <!-- Footer -->
      <footer class="sticky-footer bg-white" v-show="admin_sidebar || manager_sidebar">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span style="color: #3d388d; font-size: 1.4em"
              >Design & develop by unique it center</span
            ><br />
            <span style="color: #3d388d; font-size: 1.2em"
              >Copyright &copy; 2023 HKF Real Estate Ltd</span
            >
          </div>
        </div>
      </footer>
      <!-- End of Footer -->
    </div>
    <!-- End of Content Wrapper -->
  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
</template>
<style></style>
<script>
import NavComponent from "../components/nav.vue";
import SidebarComponent from "../components/sidebar-component.vue";
import SidebarManagerComponent from "../components/sidebar_manager.vue";
export default {
  data() {
    return {
      clicked: false,
      activeGuard: "",
      title: "",
      manager_sidebar: false,
      admin_sidebar: false,
    };
  },

  components: {
    NavComponent,
    SidebarComponent,
    SidebarManagerComponent,
  },
  created() {
    this.isAuthenticated = User.hasLoggedIn();
    this.activeGuard = User.getGuard();
    if (User.getGuard() == "admin") {
      this.title = "Admin";
    } else if (User.getGuard() == "manager") {
      this.title = "Manager";
    }
    this.updateSidebar();
  },
  computed: {
    validRoutes() {
      const routes = [
        "home",
        "register_admin",
        "login_admin",
        "admin_dashboard",
        "manager_dashboard",
        "login_manager",
        "register_manager",
        "add_project",
        "all_project",
        "edit_project",
        "view_project",
        "add_stage",
        "edit_stage",
        "add_client",
        "all_client",
        "view_client",
        "tin_client",
        "nid_client",
        "passport_client",
        "edit_client",
        "receipt_voucher",
        "all_voucher",
        "view_voucher",
        "edit_voucher",
        "print_voucher",
        "payment_voucher",
        "payment_all_voucher",
        "all_unit",
        "edit_unit",
        "unit",
        "add_supplier",
        "all_supplier",
        "edit_supplier",
        "payment_view_voucher",
        "payment_edit_voucher",
        "payment_print_voucher",
        "receipt_document",
        "accounts_payable",
        "accounts_receivable",
        "sales_journal",
        "purchase_journal",
        "ledger",
        "purchase_ledger",
        "apledger",
        "cash_ledger",
        "bank_ledger",
        "sales_ledger",
        "rpledger",
        "all_pay_payable",
        "edit_pay_payable",
        "pay_payable",
        "purchase_return",
        "all_purchase_return",
        "edit_purchase_return",
        "add_purchase_land",
        "edit_purchase_land",
        "all_purchase_land",
        "view_purchase_land",
        "create_sales",
        "all_sales",
        "edit_sales",
        "view_sales",
        "all_pay_receivable",
        "edit_pay_receivable",
        "pay_receivable",
        "all_expense",
        "edit_expense",
        "add_expense",
        "view_expense",
        "add_employee",
        "all_employee",
        "view_employee",
        "edit_employee",
        "pay_employee",
        "edit_salary",
        "view_salary",
        "trial_balance",
        "add_stock_journal",
        "all_stock_journal",
        "edit_stock_journal",
        "view_stock_journal",
        "add_reference",
        "edit_reference",
        "all_reference",
        "view_reference",
        "add_member",
        "edit_member",
        "all_member",
        "view_member",
        "project_base_member",
        "project_lists",
        "add_manager_approve",
        "all_manager_approve",
        "edit_manager_approve",
        "delete_manager",
        "update_password",
        "accounts_access",
        "payment_history",
        "edit_payment_history",
        "receipt_history",
        "edit_receipt_history",
        "view_payment_history",
        "update_payment_history",
        "view_receipt_history",
        "update_receipt_history",
        "advance_pay",
        "edit_advance_pay",
        "all_advance_pay",
        "view_advance_pay",
        "pay_construction",
        "all_pay_construction",
        "view_pay_construction",
        "edit_pay_construction",
        "edit_required_construction",
        "view_required_construction",
        "all_required_construction",
        "required_construction",
        "building_lists",
        "building_base_member",
        "construction_project_list",
        "construction_project_base",
        "construction_building_list",
        "construction_building_base",
        "help",
        "merge_required_construction",
        "view_merge_construction",
        "pay_merge_construction",
        "edit_merge_construction",
        "salary_sheet",
        "view_pay_single_construction",
        "stock_transfer",
        "all_stock_transfer",
        "view_stock_transfer",
        "edit_stock_transfer",
        "create_building",
        "edit_building",
        "view_building",
        "index_building",
        "create_sales_building",
        "sales_project",
        "sales_project_report",
        "sales_building",
        "all_category",
        "late_fine",
      ];
      return routes;
    },
    isManager() {
      return this.manager_sidebar;
    },
    isAdmin() {
      return this.admin_sidebar;
    },
    containerDynamic() {
      return {
        container_custom:
          this.$route.path === "/manager/register" ||
          this.$route.path === "/admin/register" ||
          this.$route.path === "/admin/login" ||
          this.$route.path === "/manager/login",
      };
    },
  },

  watch: {
    $route: "updateSidebar",
    // $route: "hashchange",
  },
  methods: {
    forSidebar(data) {
      this.clicked = data;
    },
    authenticatedRoutes(routeName) {
      return this.validRoutes.includes(routeName);
    },
    updateSidebar() {
      if (User.getGuard() === "admin") {
        this.admin_sidebar = true;
        window.scrollTo(0, 0);
      } else if (User.getGuard() === "manager") {
        this.manager_sidebar = true;
        window.scrollTo(0, 0);
      } else {
        this.admin_sidebar = false;
        this.manage_sidebar = false;
        window.scrollTo(0, 0);
      }
    },
    hashchange() {
      // Scroll to the top of the page
      window.scrollTo(0, 0);
    },
  },
};
</script>
<style>
.container_custom {
  padding: 0 !important;
}
</style>
