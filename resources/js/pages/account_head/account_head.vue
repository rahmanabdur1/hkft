<template>
  <div >
    <h2 class="hkf_title text-center mb-4 ">Account Head</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_account_head' }" class="btn btn-primary"
          >Add Account Head</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Account Head"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table ">
      <thead>
        <tr>
           <th>Date</th>
          <th>Account Code  </th>
          <th>Account Head <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Balance</th>
          <th>Account Type</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="account_head in filterSearch" :key="account_head.id">
          <td>{{account_head.date}}</td>
          <td>{{ account_head.account_code }}</td>
          
          <td
          >
            {{ account_head.account_head }}
          </td>
          <td>
            {{ account_head.opening_balance }} tk
          </td>
           <td>
            {{ account_head.type_name }}
          </td>
          <td class="remove_bg_td">
             <router-link
              class="btn"
              :to="{ name: 'edit_account_head', params: { id: account_head.id } }"
              ><i class="fas fa-edit"></i
            ></router-link>
          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>
      
    
    </table>
  </div>
</template>
<script>
export default {
  name: "all_project",
  data() {
    return {
      account_heads: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.account_heads.sort((a, b) => {
          const nameA = a.account_head.toUpperCase();
          const nameB = b.account_head.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.account_heads.sort((a, b) => {
          const nameA = a.account_head.toUpperCase();
          const nameB = b.account_head.toUpperCase();
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
    fetchProjects(){
      axios
        .get("/api/account_head" )
        .then((res) => {
          this.account_heads = res.data;
          
          
        })
        .catch((error) => {
          console.log(error);
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
      return this.account_heads.filter((account_head) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = account_head.account_head.toLowerCase();
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
        vm.$router.push({ name: "account_head" });
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
  color: #63cb49  !important;
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
  display:inline;
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
.pagination li a :hover{
  background-color: #007bff;
  color: #ffffff;
}

</style>
