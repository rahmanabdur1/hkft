<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Manager To Accounts</h2>

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


        <div class='text-right col-md-4'>
              <button type="submit" class="btn btn-primary mb-2">Save</button>
        </div>
        </form>
          <table class="table">
      <thead>
        <tr>
          <th>Manager Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="manager in managers" :key="manager.id">
          <td>{{ manager.manager_name }}</td>

        <td>
            <button
              class="action_danger btn ml-2"
                @click='deleteManager(manager.id)'
              >Delete</button
            >

          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>

      <!-- <div class='pagination'>
      <ul v-if="lastPage > 1">
      <li v-for="page in lastPage" :key="page" :class="{ 'active': page === currentPage }">
        <router-link :to="{name:'account_type'}" @click.prevent="setPage(page)">{{ page }}</router-link>
      </li>
    </ul>
    </div> -->
    </table>

      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "accounts_access",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "accounts_access" });
      }
    });
  },
  data() {
    return {
      form: {
        manager_name: "",
        project: "",
      },
    managers:[],
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

      axios.get('/api/accounts_access').then((res)=>{
        this.allManagers = res.data;
      }).catch((err)=>{
      });
      axios.get('/api/fetch_access_manager').then((res)=>{
        this.managers = res.data;
      })
  },
  methods: {
    addAccountType() {

      axios
        .post("/api/accounts_access", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
        .then((res) => {
          this.$router.push({ name: "admin_dashboard" });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
        });
    },
    deleteManager(id){
        Swal.fire({
  title: 'Are you sure?',
  text: "You won't be able to revert this!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  confirmButtonText: 'Yes, delete it!'
}).then((result) => {
  if (result.isConfirmed) {
    axios.delete('/api/delete_accounts_access/'+id).then((res)=>{
        this.managers = this.managers.filter((res)=>{
            return res.id!=id;
});
       })
    Swal.fire(
      'Deleted!',
      'Your file has been deleted.',
      'success'
    )
  }
})

    }
  },
};
</script>
