<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Supplier</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_supplier' }" class="btn btn-primary"
          >Add Supplier</router-link
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
          <th>Sl</th>
          <th>Supplier Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Supplier ID</th>
          <th>Supplier Phone</th>
          <th>Supplier Location</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(supplier, index) in filterSearch" :key='index'>
          <td>{{ index + 1 }}</td>

          <td>{{ supplier.supplier_name }}</td>
          <td>{{ supplier.supplier_id }}</td>
          <td>{{ supplier.phone }}</td>
          <td>{{ supplier.supplier_location }}</td>

          <td class="remove_bg_td">
            <router-link
              class="action btn"
              :to="{ name: 'edit_supplier', params: { id: supplier.id } }"
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
  name: "all_supplier",
  data() {
    return {
      suppliers: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.suppliers.sort((a, b) => {
          const nameA = a.supplier_name.toUpperCase();
          const nameB = b.supplier_name.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.suppliers.sort((a, b) => {
          const nameA = a.supplier_name.toUpperCase();
          const nameB = b.supplier_name.toUpperCase();
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
    fetchSuppliers(url) {
      axios
        .get(url)
        .then((res) => {
          this.suppliers = res.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  created() {
    this.fetchSuppliers("/api/supplier");
  },
  computed: {
    filterSearch() {
      return this.suppliers.filter((supplier) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = supplier.supplier_name.toLowerCase();
        return typeName.match(search_Term);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
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
  color: #228b08 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
</style>
