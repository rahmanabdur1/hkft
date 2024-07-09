<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Construction Cost</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_pay_construction' }" class="btn btn-primary">
        Construction Paid Lists</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Date</label>
            <input type="date" class="form-control" v-model="form.basic_date" required />
          </div>

          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Pay Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Amount"
              v-model="form.paid_amount"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Purpose/Note</label>
            <input
              type="text"
              class="form-control"
              placeholder="Note"
              v-model="form.note"
            />
          </div>
          <div class="col-md-6 text-right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
          <!-- -->
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "pay_merge_construction" });
      }
    });
  },
  data() {
    return {
      admin: false,
      manager: false,
      logo: "",
      isBuilding: false,
      projects: [],
      buildings: [],
      allClients: [],
      client_nid: "",
      list_style: true,
      client_search: "",
      allProjects: [],

      form: {
        construction_id: "",
        selectedProject: "",
        selectedBuilding: "",
        paid_amount: "",
        note: "",
        client_name: "",
        basic_date: "",
        client_id: "",
        all_client: "",
        clients: [],
      },
    };
  },

  methods: {
    addProject() {
      this.form.construction_id = this.$route.params.id;
      axios
        .post("/api/pay_construction_merge", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_pay_construction" });
        })
        .catch((err) => {
          console.log(err.response);
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
