<template>
  <div>
    <div class="row">
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Voucher ID"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Voucher No</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="project in filterSearch">
          <td>{{ project.payment_id }}</td>

          <td class="remove_bg_td">
            <router-link
              class="action_success btn mr-2"
              :to="{
                name: 'view_payment_history',
                params: { id: project.payment_id },
              }"
              >View</router-link
            >
            <router-link
              class="action_success btn mr-2"
              :to="{
                name: 'edit_payment_history',
                params: { id: project.payment_id },
              }"
              >Edit</router-link
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
                axios.get("/api/getManagerPaymentHistory/" + item.project).then((res) => {
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
    this.fetchProjects("/api/fetch_supplier_history");
  },
  computed: {
    filterSearch() {
      return this.members.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.payment_id.toLowerCase();
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
        vm.$router.push({ name: "payment_history" });
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
