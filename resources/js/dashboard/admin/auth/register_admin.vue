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
                <form class="user login_user" @submit.prevent="register">
                  <div class="form-group">
                    <label class="label_style">Enter Your Username</label>
                    <input
                      type="text"
                      class="form-control form-control-user input_form"
                      id=""
                      aria-describedby="emailHelp"
                      placeholder="Enter User Name..."
                      v-model="form.username"
                    />
                    <small class="text text-danger" v-if="errors.username">{{
                      errors.username[0]
                    }}</small>
                  </div>
                  <div class="form-group">
                    <label class="label_style">Enter Your Email</label>

                    <input
                      type="email"
                      class="form-control form-control-user input_form"
                      id=""
                      aria-describedby="emailHelp"
                      placeholder="Enter Email Address..."
                      v-model="form.email"
                    />
                  </div>
                  <small class="text text-danger" v-if="errors.email">{{
                    errors.email[0]
                  }}</small>

                  <div class="form-group">
                    <label class="label_style">Enter Your Password</label>

                    <input
                      type="password"
                      class="form-control form-control-user input_form"
                      id="exampleInputPassword"
                      placeholder="Password"
                      v-model="form.password"
                    />
                    <small class="text text-danger" v-if="errors.password">{{
                      errors.password[0]
                    }}</small>
                  </div>
                  <small class="text text-danger" v-if="username_exists"
                    >Username Already exists</small
                  >

                  <button class="btn loginBtn btn-user btn-block">Registration</button>
                  <hr />
                </form>
                <hr />
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
  name: "register_admin",
  data() {
    return {
      form: {
        username: null,
        email: null,
        password: null,
      },
      errors: {},
      username_exists: false,
      guard: "",
    };
  },
  created() {
    this.guard = User.getGuard();
    if (this.guard) {
      this.$router.push({ name: "login_admin" });
    }
  },
  methods: {
    register() {
      const headers = {
        "Content-Type": "application/json",
        "Accept": 'application/json'
      };

      axios
        .post("/api/admin/register", this.form, { headers })
        .then((res) => {
          if (res.data) {
            User.responseAfterRegister(res);
            if (res.data.token) {
              this.$router.push({ name: "login_admin" });
              location.reload();
            }
          } else {
            this.username_exists = true;
          }
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
  },
};
</script>
<style></style>
