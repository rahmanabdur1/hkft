<template>
  <div>
    <nav
      class="navbar navbar-expand navbar-light admin_nav topbar mb-4 static-top shadow"
      v-show="!hideNavbarSidebar"
    >
      <!-- Sidebar Toggle (Topbar) -->
      <button
        id="sidebarToggleTop"
        class="btn btn-link d-md-none rounded-circle mr-3"
      ></button>

      <!-- Topbar Search -->
      <div class="text-center d-none d-md-inline">
        <button
          @click="toggleData"
          class="rounded-circle border-0"
          id="sidebarToggle"
          style="background: #605ca8; color: white"
        >
          <i class="fa fa-bars" style="font-size: 1.5rem" aria-hidden="true"> </i>
        </button>
      </div>
      <div class="sidebar-brand-text mx-3">
        <h5 style="color: white !important; font-size: 100% !important">
          HKF Real Estate Ltd
        </h5>
      </div>
      <!-- <form
    class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
    <div class="input-group">
        <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
            aria-label="Search" aria-describedby="basic-addon2">
        <div class="input-group-append">
            <button class="btn btn-primary" type="button">
                <i class="fas fa-search fa-sm"></i>
            </button>
        </div>
    </div>
</form> -->

      <!-- Topbar Navbar -->
      <ul class="navbar-nav ml-auto">
        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
        <li class="nav-item dropdown no-arrow d-sm-none">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            id="searchDropdown"
            role="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            <i class="fas fa-search fa-fw"></i>
          </a>
          <!-- Dropdown - Messages -->
          <div
            class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
            aria-labelledby="searchDropdown"
          >
            <form class="form-inline mr-auto w-100 navbar-search">
              <div class="input-group">
                <input
                  type="text"
                  class="form-control bg-light border-0 small"
                  placeholder="Search for..."
                  aria-label="Search"
                  aria-describedby="basic-addon2"
                />
                <div class="input-group-append">
                  <button class="btn btn-primary" type="button">
                    <i class="fas fa-search fa-sm"></i>
                  </button>
                </div>
              </div>
            </form>
          </div>
        </li>

        <!-- Nav Item - Alerts -->
        <li class="nav-item dropdown no-arrow mx-1">
          <router-link
            class="nav-link dropdown-toggle"
            :to="{ name: 'all_stock_journal' }"
            @click="resetNotification"
            id="alertsDropdown"
            role="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            <i class="fas fa-bell fa-fw"></i>
            <!-- Counter - Alerts -->
            <span class="badge badge-danger badge-counter" v-if="notification != 0"
              >{{ notification }}+</span
            >
          </router-link>
          <!-- Dropdown - Alerts -->
        </li>

        <div class="topbar-divider d-none d-sm-block"></div>

        <!-- Nav Item - User Information -->
        <li class="nav-item dropdown no-arrow">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            id="userDropdown"
            role="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            <span class="mr-2 d-none d-lg-inline text-gray-600 small">{{
              username
            }}</span>
            <img class="img-profile rounded-circle" :src="'../img/' + profileImg" />
          </a>
          <!-- Dropdown - User Information -->
          <div
            class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="userDropdown"
          >
            <router-link :to="{ name: 'update_password' }" class="dropdown-item" href="#">
              <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
              Password Change
            </router-link>
            <router-link :to="{ name: 'help' }" class="dropdown-item" href="#">
              <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
              Help & Guideline
            </router-link>
            <button @click="logout" class="dropdown-item">
              <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
              Logout
            </button>
          </div>
        </li>
      </ul>
    </nav>
  </div>
</template>
<script>
export default {
  name: "navcomponent",
  data() {
    return {
      clicked: false,
      logout_manager: false,
      logout_admin: false,
      username: "",
      notification: 0,
      profileImg: "undraw_profile.svg",
    };
  },
  created() {
    this.username = User.getUserName();
    axios
      .get("/api/notification")
      .then((res) => {
        if (res.data.notification > 0) {
          this.notification = res.data.notification;
        }
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    getImagePath(imagePath) {
      return process.env.BASE_URL + imagePath;
    },
    toggleData() {
      this.clicked = !this.clicked;
      this.$emit("toggleButton", this.clicked);
    },
    resetNotification() {
      axios
        .get("/api/reset_notification")
        .then((res) => {
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    logout() {
      User.logout();

      this.$router.push({ name: "home" });
    },
  },
  computed: {
    hideNavbarSidebar() {
      return (
        this.$route.path === "/admin/register" ||
        this.$route.path === "/admin/login" ||
        this.$route.path === "/manager/register" ||
        this.$route.path === "/manager/login" ||
        this.$route.path === "/"
      );
    },
  },
};
</script>
