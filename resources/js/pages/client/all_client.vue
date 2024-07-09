<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Client</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_client' }" class="btn btn-primary"
          >Add Client</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by (client name, phone, ID)"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
      <div class="col-sm-4 mt-4" v-if="isadmin">
        <label for="" class="hkf_text">Select Project</label>

        <select
          class="form-control status"
          v-model="clientUnderProject"
          @change="checkOption"
        >
          <option
            v-for="(project, index) in projects"
            :value="project.clientUnderProject"
            :key="index"
          >
            {{ project.clientUnderProject }}
          </option>
        </select>
      </div>
      <div class="col-sm-4 mt-4" v-if="ismanager">
        <label for="" class="hkf_text">Select Project</label>
        <select
          class="form-control status"
          v-model="clientUnderProject"
          @change="checkOption"
        >
          <option
            v-for="(project, index) in projects"
            :value="project.project"
            :key="index"
          >
            {{ project.project }}
          </option>
        </select>
      </div>
      <div class="col-md-4 mt-4" v-if="isBuilding">
        <label for="projectName" class="hkf_text">Select Building</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedBuilding"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseBuilding"
          required
        >
          <option
            v-for="(project, index) in buildings"
            :key="index"
            :value="project.building_name"
          >
            {{ project.building_name }}
          </option>
        </select>
      </div>
    </div>
    <button
      type="button"
      class="btn action_print mt-4 mb-5"
      style="margin-left: 90%"
      @click="printContent"
    >
      Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
    </button>
    <div style="display: flex; width: 100%" class="row clientTh">
      <div id="print-container" style="width: 80%">
        <table
          class="table"
          style="width: 100%; border: 1px solid black; border-collapse: collapse"
        >
          <!-- <thead class="thead"> -->
          <tr>
            <th
              scope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              SL <i class="fa fa-sort" @click="sorting_asc"></i>
            </th>
            <th
              scope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              Client ID
            </th>
            <th
              scope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              Client Name
            </th>
            <th
              scope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              Client Project
            </th>
            <th
              scope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              Phone
            </th>
          </tr>
          <!-- </thead> -->
          <tbody>
            <tr
              v-for="(client, index) in filterSearch"
              style="height: 63px !important"
              class="clientData"
              :key="index"
            >
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ index + 1 }}
              </td>
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ client.client_id }}
              </td>
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ client.name }}
              </td>
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ client.clientUnderProject }}
              </td>
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ client.phone }}
              </td>
            </tr>

            <!-- add more rows as needed -->
          </tbody>
        </table>
      </div>
      <div style="width: 20%">
        <table
          class="table"
          style="width: 100%; border: 1px solid black; border-collapse: collapse"
        >
          <!-- <thead class="thead"> -->
          <tr>
            <th
              cope="col"
              style="
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
              "
            >
              Action
            </th>
          </tr>
          <!-- </thead> -->
          <tbody>
            <tr
              v-for="(client, index) in filterSearch"
              style="height: 63px !important"
              class="clientAction"
              :key="index"
            >
              <td
                scope="row"
                class="action_td"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                <router-link
                  class="btn"
                  :to="{ name: 'edit_client', params: { id: client.id } }"
                  ><i class="fas fa-edit"></i
                ></router-link>
                <router-link
                  class="btn"
                  :to="{ name: 'view_client', params: { id: client.id } }"
                  ><i class="fa fa-eye"></i
                ></router-link>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "all_client",
  data() {
    return {
      clients: [],
      sorting: false,
      searchTerm: "",
      gaurd: "",
      manager_username: "",
      projects: [],
      clientUnderProject: "",
      allprojects: [],
      isadmin: false,
      ismanager: false,
      isBuilding: false,
      buildings: [],
      selectedBuilding: "",
    };
  },

  methods: {
    printContent() {
      const printContents = document.getElementById("print-container").innerHTML;
      const originalContents = document.body.innerHTML;
      const popupWin = window.open("width=800,height=800");
      popupWin.document.open();
      popupWin.document.write(`
          <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.25rem;

              }
              .custom_table,thead,th,tr,td{
                border:1px solid black;
              }

            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({ name: "all_client" });
    },
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.clients.sort((a, b) => {
          const nameA = a.name.toUpperCase();
          const nameB = b.name.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.clients.sort((a, b) => {
          const nameA = a.name.toUpperCase();
          const nameB = b.name.toUpperCase();
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
    fetchClients() {
      //admin & manager
      //admin  & manager
      this.guard = User.getGuard();
      if (this.guard == "admin") {
        this.isadmin = true;
        this.ismanager = false;
        axios.get("/api/fetchSingleProjectClient").then((res) => {
          this.projects = res.data;
          console.log(res.data);
        });
        axios
          .get("/api/client")
          .then((res) => {
            this.clients = res.data;
            console.log(this.clients);
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else if (this.guard == "manager") {
        this.isadmin = false;
        this.ismanager = true;
        this.manager_username = User.getUserName();
        axios
          .get("/api/getManagerProject/" + this.manager_username)
          .then((res) => {
            this.projects = res.data;

            const promises = [];
            this.projects.forEach((item) => {
              promises.push(
                axios
                  .get("/api/getManagerProjectClient/" + item.project)
                  .then((res) => {
                    return res.data;
                  })
                  .catch((err) => {
                    console.log(err.response);
                  })
              );
            });

            Promise.all(promises).then((res) => {
              this.clients = res.flat();
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      }

      //
    },
    chooseBuilding() {
      axios
        .get("/api/fetchByBuildingClient/" + this.selectedBuilding)
        .then((res) => {
          this.clients = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    checkOption() {
      this.isBuilding = true;
      axios
        .get("/api/getSingleProjectClient/" + this.clientUnderProject)
        .then((res) => {
          this.clients = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/fetchBuildingInventory/" + this.clientUnderProject)
        .then((res) => {
          this.buildings = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },

  created() {
    this.fetchClients();
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "all_client" });
    }
  },
  computed: {
    filterSearch() {
      return this.clients.filter((client) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = client.name.toLowerCase();
        const phone = client.phone.toLowerCase();
        const client_id = client.client_id.toLowerCase();
        if (phone) {
          return (
            typeName.includes(search_Term) ||
            phone.includes(search_Term) ||
            client_id.includes(search_Term)
          );
        } else if (!phone) {
          return typeName.includes(search_Term) || client_id.includes(search_Term);
        }
      });
    },
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
table tr:nth-child(even) .action_td {
  background: #a9abbf;
}

.action {
  color: white;
  background: #3d388d;
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
.header_table {
  border-bottom: 1px solid #605ca8;
}
.fa-edit {
  color: #002bff;
  font-size: 1.2em;
}
.fa-eye {
  color: green;
  font-size: 1.2em;
}
th {
  font-size: 1.2em;
}
@media only screen and (min-width: 1200px) {
  .clientAction,
  .clientData {
    height: 60px;
  }
  .clientTh th {
    height: 80px !important;
  }
  .clientAction td,
  .clientData td {
    height: 100px !important;
  }
}

@media only screen and (min-width: 600px) and (max-width: 1199px) {
  .clientAction,
  .clientData {
    height: 60px;
  }
  .clientTh th {
    height: 80px !important;
  }
  .clientAction td,
  .clientData td {
    height: 98px !important;
  }
}
.clientTh th {
  height: 80px !important;
}
.clientAction td,
.clientData td {
  height: 63px;
}
</style>
