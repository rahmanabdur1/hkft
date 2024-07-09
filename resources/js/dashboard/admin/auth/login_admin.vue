<template>
  <!-- Outer Row -->
  <div class="row justify-content-center login_content">
    <div class="col-xl-10 col-lg-12 col-md-9">
      <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
          <!-- Nested Row within Card Body -->
          <div class="row">
            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
            <div class="col-lg-6">
              <div class="p-5">
                <div class="text-center">
                  <h1 class="h4 c-title mb-4">H K F!</h1>
                </div>
                <form class="user login_user" @submit.prevent="login">
                  <div class="form-group">
                    <label class="label_style">Enter Your Username</label>

                    <input
                      type="text"
                      class="form-control form-control-user input_form"
                      id="exampleInputEmail"
                      aria-describedby="emailHelp"
                      placeholder="Enter User Name..."
                      v-model="form.username"
                    />
                  </div>
                  <div class="form-group">
                    <label class="label_style">Enter Your Password</label>

                    <input
                      type="password"
                      class="form-control form-control-user input_form"
                      id="exampleInputPassword"
                      placeholder="Password"
                      v-model="form.password"
                    />
                    <small class="text text-danger" v-if="errors"
                      >Username or password invalid</small
                    >
                  </div>
                  <button class="btn loginBtn btn-user btn-block">Login</button>

                </form>
                <hr />
                <div class="text-center">
                  <!-- <router-link class="small" href="forgot-password.html">Forgot Password?</router-link> -->
                </div>
                <div class="text-center">
                  <!-- <router-link class="small" href="register.html">Create an Account!</router-link> -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "login_admin",
  created() {
    if (User.hasLoggedIn()) {
      if (User.getGuard() == "admin") {
        this.$router.push({ name: "admin_dashboard" });
      }
    }
  },
  data() {
    return {
      form: {
        username: null,
        password: null,
      },
      errors: false,
      activeGuard: "",
      componentKey: 0,
    };
  },

  methods: {
    login() {
      axios
        .post("/api/admin/login", this.form,{
            headers:{
                'Content-Type':'application/json',
                'Accept':'application/json',
            }
        })
        .then((res) => {
          User.responseAfterLogin(res);

          this.$router.push({ name: "admin_dashboard" });
          location.reload();
        })
        .catch((error) => {
          this.errors = true;
        });
    },
  },
};
</script>
<style>
.login_user {
  font-size: 1.2rem;
  border-radius: 10rem;
  padding: 0.75rem 1rem;
}
</style>
