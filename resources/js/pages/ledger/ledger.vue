<template>
  <div>
    <nav>
      <ol class="nav ledger_nav " >
        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'purchase_ledger' }"
            >Purchase Ledger</router-link
          >
        </li>
        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'sales_ledger' }"
            >Sales Ledger</router-link
          >
        </li>
        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'apledger' }"
            >Accounts Payable Ledger</router-link
          >
        </li>
        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'rpledger' }"
            >Accounts Receivable Ledger</router-link
          >
        </li>
        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'cash_ledger' }"
            >Cash Ledger</router-link
          >
        </li>

        <li class="nav-item ledger_li">
          <router-link class=" ledger_link" :to="{ name: 'bank_ledger' }"
            > Bank Ledger</router-link
          >
        </li>
      </ol>
    </nav>
  </div>
</template>
<script>
export default {
     beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
          axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "ledger" });
      }
    });
  },
}
</script>
<style >
    .ledger_li{
        margin:0.5rem;
        list-style:square;
    }
    .ledger_link{
        width:100%;
        color:#605CA8 !important;
    }
    .ledger_link:hover{
        text-decoration:none;
        color:#3d388d !important;
    }
    .ledger_nav{

        display:block;
    }

</style>
