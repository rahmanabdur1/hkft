<template>
  <div>
    <h2 class="hkf_title text-center mb-4 "> Return Lists</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'purchase_return' }" class="btn btn-primary"
          >Purchase Return</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Payment Voucher"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Date <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Supplier Name</th>
          <th>Returned Quantity</th>
          <th>Returned Amount</th>
          <th>Payment ID</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(payable,index) in filterSearch" :key='index'>
          <td>{{ payable.date }}</td>
          <td>{{ payable.supplier_name }}</td>
          <td>{{payable.return_qty}}</td>
          <td>{{payable.return_amount}}</td>
          <td

          >
            {{ payable.payment_id }}
          </td>

          <td class="remove_bg_td">
            <router-link
              class="action btn" style='width:70px'
              :to ="{ name: 'edit_purchase_return', params: { id: payable.id } }"
              >Update</router-link
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
  name: "all_purchase_return",
  data() {
    return {
      payables: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.payables.sort((a, b) => {
          const nameA = a.payable_date.toUpperCase();
          const nameB = b.payable_date.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.payables.sort((a, b) => {
          const nameA = a.payable_date.toUpperCase();
          const nameB = b.payable_date.toUpperCase();
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
    fetchApledgers(url) {
      axios
        .get(url)
        .then((res) => {
          this.payables = res.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  created() {

    this.fetchApledgers("/api/purchase_return_all");
  },
  computed: {
    filterSearch() {
      return this.payables.filter((payable) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = payable.payment_id.toLowerCase();
        return typeName.match(search_Term);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }  else {
        vm.$router.push({ name: "all_purchase_return" });
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
  color: #66a756  !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
</style>
