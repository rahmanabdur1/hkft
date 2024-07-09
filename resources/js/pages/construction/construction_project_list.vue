<template>
  <div>
    <div class="row">
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Name"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Project Name</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="project,index in filterSearch" :key='index'>
          <td>{{ project.selectedProject }}</td>

          <td class="remove_bg_td">
            <router-link
              class="action_success btn"
              :to="{
                name: 'construction_project_base',
                params: { id: project.selectedProject },
              }"
              >View</router-link
            >
          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: "all_member",
  data() {
    return {
      members: [],
      sorting: false,
      searchTerm: "",
      allProjects: [],
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.members.sort((a, b) => {
          const nameA = a.selectedProject.toUpperCase();
          const nameB = b.selectedProject.toUpperCase();
          if (nameA < nameB) {
            return 1;
          }
          if (nameA > nameB) {
            return -1;
          }
          return 0;
        });
      } else {
        return this.members.sort((a, b) => {
          const nameA = a.selectedProject.toUpperCase();
          const nameB = b.selectedProject.toUpperCase();
          if (nameA > nameB) {
            return 1;
          }
          if (nameA < nameB) {
            return -1;
          }
          return 0;
        });
      }
    },
    fetchProjects(url) {
      //admin  & manager
      this.guard = User.getGuard();
      if (this.guard == "admin") {
        this.admin = true;
        this.manager = false;
        axios
          .get(url)
          .then((res) => {
            this.members = res.data;
            console.log(res.data);
          })
          .catch((error) => {
            console.log(error);
          });
      } else if (this.guard == "manager") {
        this.manager = true;
        this.admin = false;
        this.manager_username = User.getUserName();
        axios
          .get("/api/getManagerProject/" + this.manager_username)
          .then((res) => {
            const promises = [];
            res.data.forEach((item) => {
              promises.push(
                axios
                  .get("/api/getManagerProjectClientListConstruction/" + item.project)
                  .then((res) => {
                    return res.data;
                  })
              );
            });

            Promise.all(promises).then((res) => {
              this.members = res.flat();
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
      //end
    },
    deleteMemberInfo($id) {
      axios
        .delete("/api/project_member/" + $id)
        .then((res) => {
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  created() {
    this.fetchProjects("/api/construction_project_list");
  },
  computed: {
    filterSearch() {
      return this.members.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.selectedProject.toLowerCase();
        return typeName.match(search_Term);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "construction_project_list" });
      }
    });
  },
};
</script>
<style>
.hkf_text {
  color: #4e3089 !important;
}
th {
  font-weight: bold;
  color: #473b5edb;
}
table tr:nth-child(even) {
  background-color: #605ca8 !important;
  color: white;
}
.action {
  color: white;
  background: #5d57c3;
  padding: 5px;
  width: 60px;
}
.action_danger {
  color: white;
  background: red;
  padding: 5px;
  width: 60px;
}
.action_success {
  color: white;
  background: green;
  padding: 5px;
  width: 60px;
}
table tr:nth-child(odd) {
  color: #473b5edb;
  font-weight: bold;
}
.status_project {
  font-weight: bold;
  font-size: 1.2rem;
}
.text-warning {
  color: #35354c !important;
}
.text-info {
  color: #36becc !important;
}
.text-success {
  color: #66a756 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
</style>
