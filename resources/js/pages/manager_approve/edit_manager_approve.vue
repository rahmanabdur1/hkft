<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Manager</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_manager_approve' }" class="btn btn-primary"
        >All Registered</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form  @submit.prevent="addAccountType()">
         <div class="form-group mx-sm-3 mb-2 col-md-4 " >
                <label for="projectName" class="hkf_text">Select Manager</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.manager_name"
                  required
                >
                  <option
                    v-for="(project, index) in allManagers"
                    :key="index"
                    :value="project.username"
                  >
                    {{ project.username }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2 col-md-4" >
                <label for="projectName" class="hkf_text">{{form.project}}</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.project"
                  required
                >
                  <option
                    v-for="(project, index) in allProjects"
                    :key="index"
                    :value="project.project_name"
                  >
                    {{ project.project_name }}
                  </option>
                </select>
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
        vm.$router.push({ name: "edit_manager_approve" });
      }
    });
  },
  data() {
    return {
      form: {
        manager_name: "",
        project: "",
      },
    allProjects:[],
    allManagers:[],
      errors: {},
    };
  },
  created(){
     axios
      .get("/api/project")
      .then((res) => {
        this.allProjects = res.data;
      })
      .catch((err) => {
      });

      axios.get('/api/getAllManager').then((res)=>{
        this.allManagers = res.data;
      }).catch((err)=>{
      });
      axios.get('/api/manager_approve/'+this.$route.params.id).then((res)=>{
        this.form = res.data;
      }).catch((err)=>{
      })
  },
  methods: {
    addAccountType() {

      axios
        .patch("/api/manager_approve/"+this.$route.params.id, this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
        .then((res) => {
          this.$router.push({ name: "all_manager_approve" });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
  },
};
</script>
