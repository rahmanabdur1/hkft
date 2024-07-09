<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Reference</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_reference' }" class="btn btn-primary"
        >All Reference</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form class="form-inline" @submit.prevent="addAccountType()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Reference Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Reference Name"
              v-model="form.reference_name"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text"> Phone</label>
            <input
              type="text"
              class="form-control"
              placeholder="Reference Phone"
              v-model="form.phone"
              required
            />
          </div>
          <button type="submit" class="btn btn-primary mb-2">Save</button>
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
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "add_reference" });
      }
    });
  },
  data() {
    return {
      form: {
        reference_name: "",
        reference_id: "",
        phone: "",
      },

      errors: {},
    };
  },
  methods: {
    addAccountType() {
      const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
      let randomString = "";
      for (let i = 0; i < 5; i++) {
        const randomIndex = Math.floor(Math.random() * alphabet.length);
        const randomLetter = alphabet.charAt(randomIndex);
        randomString += randomLetter;
      }
      const uniqueId = randomString + Math.floor(Math.random() * 100000);

      this.form.reference_id = uniqueId;
      axios
        .post("/api/reference_info", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_reference" });
        })
        .catch((error) => {
          this.errors = error.response;
          console.log(this.errors);
        });
    },
  },
};
</script>
