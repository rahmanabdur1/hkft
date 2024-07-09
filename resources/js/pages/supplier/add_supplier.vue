<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Supplier</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_supplier' }" class="btn btn-primary"
        >All Supplier</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form class="form-inline" @submit.prevent="addSupplier()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Supplier Name</label>
            <input
              type="text"
              class="form-control"
              id="projectName"
              placeholder="Supplier Name"
              v-model="form.supplier_name"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Supplier Phone</label>
            <input
              type="text"
              class="form-control"
              id="projectphone"
              placeholder="Supplier phone"
              v-model="form.supplier_phone"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">Location</label>
            <input
              type="text"
              class="form-control"
              id="location"
              name="location"
              placeholder="Location"
              v-model="form.supplier_location"
            />
          </div>

          <button type="submit" class="btn btn-primary mb-2">Save</button>
        </form>
        <small class="text text-danger" v-if="errors.supplier_name">{{
          errors.supplier_name[0]
        }}</small>
        <small class="text text-danger" v-if="errors.supplier_location">{{
          errors.supplier_location[0]
        }}</small>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_supplier",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }
    });
  },

  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "add_supplier" });
    }
  },
  data() {
    return {
      form: {
        supplier_name: "",
        supplier_id: "",
        supplier_location: "",
        supplier_phone: "",
      },

      errors: {},
    };
  },
  methods: {
    addSupplier() {
      const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
      let randomString = "";
      for (let i = 0; i < 4; i++) {
        const randomIndex = Math.floor(Math.random() * alphabet.length);
        const randomLetter = alphabet.charAt(randomIndex);
        randomString += randomLetter;
      }
      const uniqueId = randomString + "-" + Math.floor(Math.random() * 10000);
      this.form.supplier_id = uniqueId;

      axios
        .post("/api/supplier", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_supplier" });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
  },
};
</script>
<style>
label {
  margin-right: 1em;
}
.hkf_text {
  color: #000000cf !important;
  font-weight: bold;
}
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
#status {
  color: black;
}

#status option:active {
  background-color: #6e6c8b !important;
  color: #fff;
}
.text-danger {
  color: #e74a3b !important;
  font-size: 1em;
}
</style>
