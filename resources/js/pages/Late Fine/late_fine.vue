<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Late Fine & Details</h2>
    <div class="row">
      <div class="input-group col-md-6">
        <button type="button" @click="showModal()" class="btn btn-primary">
          Create Late Fine
        </button>
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
      class="table custom_table mt-5"
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
          <th>Fees Type</th>
          <th>Fixed Amount</th>
          <th>Project Name</th>
          <th>Building Name</th>
          <th colspan="2">Action</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="(unit, index) in filterSearch" :key="unit.id">
          <td style="border: 1px solid black">{{ ++index }}</td>
          <td style="border: 1px solid black">{{ unit.fee_type }}</td>
          <td style="border: 1px solid black">{{ unit.amount }}</td>
          <td style="border: 1px solid black">
            <label v-for="(project, index) in unit.project" :key="index">
              {{ project.project_name }}
              <span v-if="index < unit.project.length - 1">,</span>
            </label>
          </td>
          <td style="border: 1px solid black">
            <label v-for="(building, index) in unit.building" :key="index">
              {{ building.building_name }}
              <span v-if="index < unit.building.length - 1">,</span>
            </label>
          </td>
          <td style="border: 1px solid black">
            <button class="action btn mr-5" type="button" @click="editCategory(unit.id)">
              Edit
            </button>
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
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content modal1">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body d-flex">
            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Amount "
                  v-model="form.amount"
                />
              </div>
            </div>
            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Project Name "
                  v-model="project_search"
                  @keyup="listDisplay"
                />
              </div>
              <div>
                <ul class="ulShow" :class="{ listStyle: list_style }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style }"
                    v-for="(item, index) in filterInventory"
                    :key="index"
                    :value="item.project_name"
                    @click="assignToSearch(item)"
                  >
                    {{ item.project_name }}
                  </li>
                </ul>
              </div>
              <div class="block col-md-12">
                <!-- Dynamically render input fields using v-for -->
                <div
                  v-for="(value, index) in form.project_items"
                  :key="index"
                  class="input-wrapper"
                  style="display: flex; padding: 0.3em"
                >
                  <div class="flex">
                    <div class="col-md-8">
                      <label for="">{{ form.project_items[index].project_name }}</label>
                    </div>
                    <div class="col-md-2">
                      <i class="fa fa-trash ml-2" @click="removeProject(index)"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Building Name "
                  v-model="building_search"
                  @keyup="listDisplay1"
                />
              </div>
              <div>
                <ul class="ulShow" :class="{ listStyle: list_style1 }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style1 }"
                    v-for="(item, index) in filterInventory1"
                    :key="index"
                    :value="item.building_name"
                    @click="assignToSearch1(item)"
                  >
                    {{ item.building_name }}
                  </li>
                </ul>
              </div>
              <div class="block col-md-12">
                <!-- Dynamically render input fields using v-for -->
                <div
                  v-for="(value, index) in form.building_items"
                  :key="index"
                  class="input-wrapper"
                  style="display: flex; padding: 0.3em"
                >
                  <div class="flex">
                    <div class="col-md-8">
                      <label for="">{{ form.building_items[index].building_name }}</label>
                    </div>
                    <div class="col-md-2">
                      <i class="fa fa-trash ml-2" @click="removeBuilding(index)"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">
              Close
            </button>
            <button type="button" class="btn btn-primary" @click="saveEnter()">
              Save changes
            </button>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="exampleModal1"
      tabindex="-1"
      role="dialog"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content modal1">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body d-flex">
            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Amount "
                  v-model="form.amount"
                />
              </div>
            </div>
            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Project Name "
                  v-model="project_search"
                  @keyup="listDisplay"
                />
              </div>
              <div>
                <ul class="ulShow" :class="{ listStyle: list_style }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style }"
                    v-for="(item, index) in filterInventory"
                    :key="index"
                    :value="item.project_name"
                    @click="assignToSearch(item)"
                  >
                    {{ item.project_name }}
                  </li>
                </ul>
              </div>
              <div class="block col-md-12">
                <!-- Dynamically render input fields using v-for -->
                <div
                  v-for="(value, index) in form.project_items"
                  :key="index"
                  class="input-wrapper"
                  style="display: flex; padding: 0.3em"
                >
                  <div class="flex">
                    <div class="col-md-8">
                      <label for="">{{ form.project_items[index].project_name }}</label>
                    </div>
                    <div class="col-md-2">
                      <i class="fa fa-trash ml-2" @click="removeProject(index)"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="block col-md-4">
              <div>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Building Name "
                  v-model="building_search"
                  @keyup="listDisplay1"
                />
              </div>
              <div>
                <ul class="ulShow" :class="{ listStyle: list_style1 }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style1 }"
                    v-for="(item, index) in filterInventory1"
                    :key="index"
                    :value="item.building_name"
                    @click="assignToSearch1(item)"
                  >
                    {{ item.building_name }}
                  </li>
                </ul>
              </div>
              <div class="block col-md-12">
                <!-- Dynamically render input fields using v-for -->
                <div
                  v-for="(value, index) in form.building_items"
                  :key="index"
                  class="input-wrapper"
                  style="display: flex; padding: 0.3em"
                >
                  <div class="flex">
                    <div class="col-md-8">
                      <label for="">{{ form.building_items[index].building_name }}</label>
                    </div>
                    <div class="col-md-2">
                      <i class="fa fa-trash ml-2" @click="removeBuilding(index)"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">
              Close
            </button>
            <button type="button" class="btn btn-primary" @click="saveEnter1()">
              Save changes
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "late_fine",
  data() {
    return {
      id: "",
      clicked: [],
      clicked1: [],
      project_search: "",
      building_search: "",
      fines: [],
      buildings: [],
      projects: [],
      sorting: false,
      searchTerm: "",
      form: {
        amount: "",
        project_items: [],
        building_items: [],
      },
      form1: {
        amount: "",
        project_items: [],
        building_items: [],
      },
      list_style: true,
      list_style1: true,
    };
  },

  methods: {
    listDisplay() {
      this.list_style = false;
    },
    listDisplay1() {
      this.list_style1 = false;
    },
    showModal() {
      this.id = "";
      $("#exampleModal").modal("toggle");
    },
    editCategory(id) {
      this.id = id;
      axios
        .get("/api/fine/" + id)
        .then((res) => {
          console.log(res.data);
          this.form.amount = res.data.amount;
          this.form.project_items = res.data.project;
          this.form.building_items = res.data.building;
        })
        .catch((err) => {
          console.log(err.response);
        });
      $("#exampleModal1").modal("toggle");
    },
    saveEnter() {
      // this.id = "";
      $("#exampleModal").modal("hide");
      axios
        .post("/api/fine", this.form)
        .then((res) => {
          this.fines.push(res.data);
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      // console.log(this.form);
    },
    saveEnter1() {
      $("#exampleModal1").modal("hide");
      axios
        .patch("/api/fine/" + this.id, this.form)
        .then((res) => {
          console.log(res.data);
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },

    fetchProjects() {
      axios
        .get("/api/project")
        .then((res) => {
          console.log(res.data);
          this.projects = res.data;
          console.log(res.data);
          //  this.currentPage = res.data.current_page;
          // this.lastPage = res.data.last_page;
        })
        .catch((error) => {
          console.log(error);
        });

      axios
        .get("/api/building")
        .then((res) => {
          console.log(res.data);
          this.buildings = res.data;
          console.log(res.data);
          //  this.currentPage = res.data.current_page;
          // this.lastPage = res.data.last_page;
        })
        .catch((error) => {
          console.log(error);
        });

      axios
        .get("/api/fine")
        .then((res) => {
          this.fines = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
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
            .delete("/api/fine/" + id)
            .then((res) => {
              this.fines = this.fines.filter((res) => {
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
    assignToSearch(item) {
      this.list_style = true;
      this.project_search = "";
      this.form.project_items.push(item);
    },
    assignToSearch1(item) {
      this.list_style1 = true;
      this.building_search = "";
      this.form.building_items.push(item);
    },
    removeProject(index) {
      this.form.project_items.splice(index, 1);
    },
    removeBuilding(index) {
      this.form.building_items.splice(index, 1);
    },
  },
  created() {
    this.fetchProjects();
  },
  computed: {
    filterSearch() {
      return this.fines.filter((item) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = item.amount.toLowerCase();
        return typeName.match(search_Term);
      });
    },
    filterInventory() {
      this.clicked = this.projects.filter((item) => {
        for (let project of this.form.project_items) {
          if (project.project_name === item.project_name) {
            return false;
          }
        }
        return true;
      });
      return this.clicked.filter((product) => {
        let product_name = this.project_search.toUpperCase();
        let inventory_name = product.project_name.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    filterInventory1() {
      this.clicked1 = this.buildings.filter((item) => {
        for (let project of this.form.building_items) {
          if (project.building_name === item.building_name) {
            return false;
          }
        }
        return true;
      });
      return this.clicked1.filter((product) => {
        let product_name = this.building_search.toUpperCase();
        let inventory_name = product.building_name.toUpperCase();
        return inventory_name.match(product_name);
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
        vm.$router.push({ name: "late_fine" });
      }
    });
  },
};
</script>
<style>
.flex {
  display: flex;
  justify-content: space-around;
}
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
.block {
  display: block;
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
.modal1 {
  width: 750px;
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
