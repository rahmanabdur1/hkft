<template>
  <div class="row">
    <div class="col-md-12">
      <div class="header">
        <h2 class="text-center mb-4 hkf_title">Edit Supplier</h2>
      </div>
      <div class="float-right" style="margin: 10px 40px 15px 0px">
        <router-link :to="{ name: 'all_supplier' }" class="btn btn-primary"
          >All Supplier</router-link
        >
      </div>
      <div class="col-md-8">
        <form @submit.prevent="updateSupplier()">
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Supplier Name</label>
              <input type="text" class="form-control" v-model="form.supplier_name" />
              <small class="text text-danger" v-if="errors.supplier_name">{{
                errors.supplier_name[0]
              }}</small>
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
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Supplier Location</label>
              <input type="text" class="form-control" v-model="form.supplier_location" />
              <small class="text text-danger" v-if="errors.supplier_location">{{
                errors.supplier_location[0]
              }}</small>
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_supplier",
  data() {
    return {
      form: {
        supplier_name: "",
        supplier_location: "",
        supplier_id: "",
        supplier_phone: "",
      },

      errors: {},
    };
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/supplier/" + id)
      .then(({ data }) => {
        this.form = data;
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    updateSupplier() {
      let id = this.$route.params.id;
      axios
        .patch("/api/supplier/" + id, this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_supplier" });
        })
        .catch((err) => {
          this.errors = err.response.data;
          console.log(this.errors);
        });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }
    });
  },
};
</script>

<style>
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
.hkf_texts {
  color: #605ca8 !important;
  font-weight: bold;
}
</style>
