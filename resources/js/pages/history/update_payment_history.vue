<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Edit Amount</h2>
    <div class="input-group col-md-6 page_to_page"></div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form class="form-inline" @submit.prevent="addSupplier()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Edit Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Edit Amount"
              v-model="form.edit_amount"
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
  name: "add_supplier",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "update_payment_history" });
      }
    });
  },

  data() {
    return {
      form: {
        edit_amount: "",
      },

      errors: {},
    };
  },
  methods: {
    addSupplier() {
      axios
        .patch("/api/history/" + this.$route.params.id, this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "payment_history" });
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
