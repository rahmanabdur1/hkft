<template>
  <h2 class="hkf_title text-center mb-4">Trial Balance</h2>
  <form @submit.prevent="trialBalance()" class="mt-5">
        <div class="form-row">

          <div class="form-group col-md-12" style="margin-top: 30px">
          <label class="hkf_text" for="">Enter Starting Financial Year (July - June)</label>
          <input type="number"    v-model="form.startYear" @keyup='Year()'>  <label class="hkf_text" v-if="form.endYear>0" for="">- {{form.endYear}}</label>
            <button type="submit" class="btn btn-primary" style="height: 38px">
             Submit
            </button>
          </div>

        </div>

      </form>
  <div class="container">
    <table class="table">
      <thead>
        <tr>
          <th></th>
          <th>Debit</th>
          <th>Credit</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Cash</td>
          <td v-if="show">{{Math.abs(trial_balance[0].totalCashBalance)}} tk</td>
          <td v-else></td>
          <td></td>
        </tr>
        <tr>
          <td>Bank</td>
          <td v-if='show'>{{Math.abs(trial_balance[0].totalBankBalance)}} tk</td>
          <td v-else></td>
          <td></td>
        </tr>
        <tr>
          <td>Purchase</td>
          <td v-if='show'>{{Math.abs(trial_balance[0].totalPurchaseBalance)}} tk</td>
          <td v-else></td>
          <td></td>
        </tr>
        <tr>
          <td>Accounts Receivable</td>
          <td v-if='show'>{{Math.abs(trial_balance[0].totalArBalance)}} tk</td>
          <td v-else></td>
          <td></td>
        </tr>
        <tr>
          <td>Sales</td>
          <td></td>
          <td v-if='show'>{{Math.abs(trial_balance[0].totalSalesBalance)}} tk</td>
          <td v-else></td>

        </tr>
        <tr>
          <td>Accounts Payable</td>
          <td></td>
          <td v-if='show'>{{Math.abs(trial_balance[0].totalApBalance)}} tk</td>
          <td v-else></td>
        </tr>
        <tr>
          <td>Total</td>
          <td>{{debitBalance}}tk</td>
          <td>{{Math.abs(creditBalance)}}tk</td>
        </tr>
        <!-- Add more rows as needed -->
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
    name:'trial_balance',
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
        vm.$router.push({ name: "trial_balance" });
      }
    });
  },
    data(){
        return{
            date:"",
            form:{
                startYear:"",
                endYear:"",
            },
            show:false,
            trial_balance:{
                totalCashBalance:"",
                totalBankBalance:"",
                totalPurchaseBalance:"",
                totalSalesBalance:"",
                totalApBalance:"",
                totalArBalance:"",
            },
            debitBalance:"",
            creditBalance:"",
        }
    },
    methods:{
        trialBalance(){
            // let date = new Date();

            axios.post('/api/trial_balance',this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                }).then((res)=>{
                this.trial_balance = res.data;
                this.debitBalance = parseInt(this.trial_balance[0].totalCashBalance)+parseInt(this.trial_balance[0].totalBankBalance)+parseInt(this.trial_balance[0].totalPurchaseBalance)+parseInt(this.trial_balance[0].totalArBalance);
               this.creditBalance =  parseInt(this.trial_balance[0].totalSalesBalance)+ parseInt(this.trial_balance[0].totalApBalance);
            }).catch((err)=>{
                console.log(err.response);
            });
            this.show = true;
        },

    },
    computed:{
        Year(){
            this.form.endYear = parseInt(this.form.startYear)+1;
            if(this.form.startYear == ""){
                this.form.endYear ="";
            }
        }
    }
}
</script>
