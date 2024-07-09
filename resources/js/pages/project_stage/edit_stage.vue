<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Stage</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'index_building' }" class="btn btn-primary"
        >All Building</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Date</label>
            <input type="date" class="form-control" v-model="form.stage_date" required />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Stage</label>
            <input
              type="text"
              class="form-control"
              placeholder="Stage Name"
              v-model="form.stage"
              required
            />
          </div>
          <div class="col-md-12 text-right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>

          <!-- -->

          <!-- -->
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_stage",

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "edit_stage" });
      }
    });
  },
  data() {
    return {
      logo: "",
      form: {
        stage: "",
        project_id: "",
        id: "",
        stage_date: new Date().toISOString().split("T")[0],
      },
      stages: [],
      Supporting_docs: "",
      options: [
        { value: "in-progress", label: "In Progress" },
        { value: "completed", label: "Completed" },
        { value: "on-hold", label: "On Hold" },
      ],
      errors: {},
    };
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/getStage/" + id)
      .then((res) => {
        this.form = res.data;
        console.log(res.data);
        if (this.stages != "") {
          this.existStage = true;
        }
      })
      .catch((err) => {
        cosnsole.log(err.response);
      });
  },
  methods: {
    addProject() {
      let id = this.$route.params.id;
      console.log(this.form);
      axios
        .patch("/api/project_stage/" + this.form.id, this.form)
        .then((res) => {
          console.log(res.data);
          this.$router.push({ name: "index_building" });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
    nidFileSelected(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.logo = event.target.result;
        this.form.logo = file;
      };
      reader.readAsDataURL(file);
    },
    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.architact_drawing = file;
      };

      reader.readAsDataURL(file);
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
