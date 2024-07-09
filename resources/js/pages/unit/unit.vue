<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Item Unit</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_unit' }" class="btn btn-primary"
        >All Product Units</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form class="form-inline" @submit.prevent="addUnit()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Item Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Item Name"
              v-model="form.item_name"
              required
            />
          </div>

          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Unit</label>
            <input
              type="text"
              class="form-control"
              placeholder="Item Unit"
              v-model="form.item_unit"
              required
            />
          </div>

          <button type="submit" class="btn btn-primary mb-2">Save</button>
        </form>
        <small class="text text-danger" v-if="errors.item_unit">{{
          errors.item_unit[0]
        }}</small>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_account_type",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "unit" });
      }
    });
  },
  data() {
    return {
      form: {
        item_name: "",
        item_unit: "",
      },

      errors: {},
    };
  },
  methods: {
    addUnit() {
      axios
        .post("/api/unit", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_unit" });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
  },
};
</script>
