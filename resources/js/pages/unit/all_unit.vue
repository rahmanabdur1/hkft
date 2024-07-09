<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Product Unit</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'unit' }" class="btn btn-primary">Add Unit</router-link>
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Type"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table
      class="table custom_table"
      style="
        width: 100%;
        border: 1px solid black;
        border-collapse: collapse;
        text-align: center;
      "
    >
      <thead>
        <tr>
          <th>Sl</th>
          <th>Item Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Item Unit</th>
          <th colspan="2">Action</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="(unit, index) in filterSearch" :key="unit.id">
          <td style="border: 1px solid black">{{ ++index }}</td>
          <td style="border: 1px solid black">{{ unit.item_name }}</td>
          <td style="border: 1px solid black">{{ unit.item_unit }}</td>
          <td style="border: 1px solid black">
            <router-link
              class="action btn mr-5"
              :to="{ name: 'edit_unit', params: { id: unit.id } }"
              >Edit</router-link
            >
            <button
              type="button"
              class="action_danger btn ml-2"
              @click="deleteUnit(unit.id)"
            >
              Delete
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: "all_project",
  data() {
    return {
      units: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.item_name.toUpperCase();
          const nameB = b.item_name.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.projects.sort((a, b) => {
          const nameA = a.item_name.toUpperCase();
          const nameB = b.item_name.toUpperCase();
          if (nameA > nameB) {
            return -1;
          }
          if (nameA < nameB) {
            return 1;
          }
          return 0;
        });
      }
    },
    fetchProjects() {
      axios
        .get("/api/unit")
        .then((res) => {
          this.units = res.data;
          //  this.currentPage = res.data.current_page;
          // this.lastPage = res.data.last_page;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteUnit(id) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          axios
            .delete("/api/deleteUnit/" + id)
            .then((res) => {
              this.units = this.units.filter((res) => {
                return res.id != id;
              });
            })
            .catch((err) => {
              console.log(err.response);
            });

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
    // setPage(page) {
    //   this.currentPage = page;
    //   this.fetchProjects();
    // },
  },
  created() {
    this.fetchProjects();
  },
  computed: {
    filterSearch() {
      return this.units.filter((item) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = item.item_name.toLowerCase();
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
        vm.$router.push({ name: "all_unit" });
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
  color: #63cb49 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination li {
  list-style: none;
  margin: 0 5px;
  display: inline;
}

.pagination li.active a {
  color: #ffffff;
  background-color: #007bff;
  border: 1px solid #007bff;
}

.pagination li a {
  color: #007bff;
  background-color: #ffffff;
  border: 1px solid #007bff;
  padding: 6px 12px;
  text-decoration: none;
  cursor: pointer;
  margin-right: 5px;
}
.pagination li a :hover {
  background-color: #007bff;
  color: #ffffff;
}
</style>
