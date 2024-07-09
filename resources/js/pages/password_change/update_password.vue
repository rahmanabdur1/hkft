<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Update Password</h2>

    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addAccountType()">
          <div class="form-group mx-sm-3 mb-2 col-md-4">
            <label class="hkf_text">Old Password</label>
            <input type="password" v-model="form.old_password" required />
          </div>
          <div class="form-group mx-sm-3 mb-2 col-md-4">
            <label class="hkf_text">New Password</label>
            <input type="password" v-model="form.new_password" required />
          </div>
          <div class="form-group mx-sm-3 mb-2 col-md-4 text-right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
          <div class="form-group mx-sm-3 mb-2 col-md-4" v-if="showError">
            <span class="hkf_text" style="color: red !important">{{ error }}</span>
          </div>
          <div class="form-group mx-sm-3 mb-2 col-md-4" v-if="showSuccess">
            <span class="hkf_text" style="color: green !important">{{ success }}</span>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_reference",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "update_password" });
      }
    });
  },
  data() {
    return {
      form: {
        old_password: "",
        new_password: "",
        username: "",
      },
      allProjects: [],
      allManagers: [],
      errors: {},
      guard: "",
      error: "",
      success: "",
      showError: false,
      showSuccess: false,
    };
  },
  created() {
    this.guard = User.getGuard();
    this.form.username = User.getUserName();
    axios
      .get("/api/project")
      .then((res) => {
        this.allProjects = res.data;
      })
      .catch((err) => {
      });

    axios
      .get("/api/getAllManager")
      .then((res) => {
        this.allManagers = res.data;
      })
      .catch((err) => {
      });
  },
  methods: {
    addAccountType() {
      if (this.guard == "admin") {
        axios
          .post("/api/update_admin_current_password", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
          .then((res) => {
            if (res.data.success) {
              this.showSuccess = true;
              this.showError = false;

              this.error = res.data.success;
              User.logout();
              this.$router.push({ name: "login_admin" });
            } else if (res.data.error) {
              this.showSuccess = false;
              this.showError = true;

              this.error = res.data.error;
            }
          })
          .catch((err) => {
          });
      } else {
        axios
          .post("/api/update_manager_current_password", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
          .then((res) => {
            if (res.data.success) {
              this.showSuccess = true;
              this.showError = false;

              this.error = res.data.success;
              User.logout();
              this.$router.push({ name: "login_manager" });
            } else if (res.data.error) {
              this.showSuccess = false;
              this.showError = true;

              this.error = res.data.error;
            }
          })
          .catch((err) => {
          });
      }
    },
  },
};
</script>
