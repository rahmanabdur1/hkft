<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Member</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_member' }" class="btn btn-primary"
          >Add Member</router-link
        >
      </div>
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
          <th>Member Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Project Name</th>
          <th>Phone</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project,index) in filterSearch" :Key='index'>
          <td>{{ project.member_name }}</td>
          <td>{{ project.project }}</td>

          <td>
            {{ project.phone_no }}
          </td>

          <td class="remove_bg_td">
            <router-link
              class="action btn"
              :to="{ name: 'edit_member', params: { id: project.id } }"
              >Edit</router-link
            >
            <router-link
              class="action_success btn ml-2"
              :to="{ name: 'view_member', params: { id: project.id } }"
              >View</router-link
            >
            <button class="action_danger btn ml-2" @click='deleteMemberInfo(project.id)'>Delete</button>
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
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.members.sort((a, b) => {
          const nameA = a.member_name.toUpperCase();
          const nameB = b.member_name.toUpperCase();
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
          const nameA = a.member_name.toUpperCase();
          const nameB = b.member_name.toUpperCase();
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
      axios
        .get(url)
        .then((res) => {
          this.members = res.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteMemberInfo($id){
      axios.delete('/api/project_member/'+$id).then((res)=>{
       location.reload();
      }).catch((err)=>{
        console.log(err.response);
      })
    }
  },
  created() {
    this.fetchProjects("/api/project_member");
  },
  computed: {
    filterSearch() {
      return this.members.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.member_name.toLowerCase();
        return typeName.match(search_Term);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "all_member" });
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
