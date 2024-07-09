<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Purchase Return</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_purchase_return' }" class="btn btn-primary"
        >All Returns</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-6 mx-auto">
        <form class="form" @submit.prevent="purchaseReturn()">
          <div class="form-group mx-sm-3 mb-2">
            <div style="display: block">
              <label for="projectName" class="hkf_title"
                style="width:100%">Supplier Name:{{ form.payee_name }}</label
              >
                <label for="projectName" class="hkf_text"
                style="width:100%">Product Name:{{ form.product_name }}</label
              >
              <label for="projectName" class="hkf_text"  style="width:100%">Search Payment Voucher:</label>
            </div>

            <input
              type="text"
              class="form-control"
              placeholder="Payment Voucher"
              v-model="payment_id_search"
              @mousedown="listDisplay"
              required
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listShow: list_style }"
                v-for="(item, index) in filterPayment"
                :key="index"
                :value="item.payment_id"
                @click="assignToSearch(item)"
              >
                {{ item.payment_id }}
              </li>
            </ul>
          </div>
             <div class="form-group mx-sm-3 mb-2">
                <label  class="hkf_text">Return Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.date" @change='calculateDate'
                  required
                />
              </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Per Unit Cost:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Per Unit Cost"
              v-model="form.per_unit_price"
              @keyup="fullPrice"
              required
              disabled
            />
          </div>

          <div class="form-group mx-sm-3 mb-2 two_group">
            <div>
              <label class="hkf_text">Quantity:</label>
              <input
                type="number"
                class="form-control"
                placeholder="Quantity"
                v-model="form.qty"
                @keyup="fullPrice"
                required
              />
            </div>
            <div>
              <label class="hkf_text">Unit:</label>
              <div style="padding: 5px">
                <label class="hkf_text">{{ this.form.item_unit }}</label>
              </div>
            </div>
          </div>
          <div class="form-group mx-sm-3 mb-2 two_group">
            <div>
              <label class="hkf_text">Total Price:</label>
              <span class="hkf_text" style="margin-right: 2px">{{
                form.total_amount
              }}</span
              ><span class="hkf_text">tk</span>
            </div>
          </div>
          <div class="form-group mx-sm-3 mb-2 two_group">
            <span
              class="hkf_text"
              style="margin-right: 2px; color: red !important"
              v-if="excess_receive"
              >{{ excess_receive_msg }}</span
            >
          </div>
          <button type="submit" class="btn btn-primary mb-2">Save</button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_project",

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }else {
        vm.$router.push({ name: "purchase_return" });
      }
    });
  },
  data() {
    return {
      payment_id_search: "",
      list_style: true,
      showBankField: false,
      showSubmit: true,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
      payments: [],
      form: {
        payment_id: "",
        per_unit_price: "",
        qty: "",
        item_unit: "",
        qty: "",
        old_total_amount: "",
        max_qty:"",
        new_total_amount:"",
        new_payment_due:"",
        remaining_due:"",
        payment_due:"",
        old_qty:"",
        date:"",
        product_name:"",
      },
      excess_receive: false,
      excess_receive_msg: "",
    };
  },
  created() {
    axios
      .get("/api/purchase_return")
      .then((res) => {
        res.data.forEach((item) => {
          if(parseInt(item.payment_due) != 0){
            this.payments.push(item);
          }
        });

      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    assignToSearch(item) {
      this.payment_id_search = item.payment_id;
      this.form.payment_id = item.payment_id;
      this.list_style = true;
      axios.get("/api/getPaymentVoucher/" + this.form.payment_id).then((res) => {
        this.form = res.data;
        this.form.old_qty = res.data.qty;
        this.form.max_qty  = Math.floor(parseInt(this.form.payment_due)/parseInt(this.form.per_unit_price));

        this.form.qty = this.form.max_qty;
        this.form.total_amount = parseInt(this.form.max_qty)*parseInt(this.form.per_unit_price);
        this.form.payment_due = res.data.payment_due;

      });
    },
    fullPrice() {
      let qty = parseInt(this.form.qty);
      let pup = parseInt(this.form.per_unit_price);
      this.form.total_amount = pup * qty;
      this.calculateTotal();
    },
    purchaseReturn() {

      if (parseInt(this.form.max_qty) < parseInt(this.form.qty)) {
        this.excess_receive = true;
        this.excess_receive_msg = "Return Amount can't be larger then Due Amount!!";
      } else {
        this.excess_receive = false;
      //send return
      this.form.remaining_due = parseInt(this.form.payment_due) - parseInt(this.form.total_amount);


      axios.post('/api/purchase_return',this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                }).then((res)=>{
      }).catch((err)=>{
        console.log(err.response);
      });
        this.$router.push({name:'all_purchase_return'});
      }


    },
  },
  computed: {
    listDisplay() {
      if (this.form.payment_id != null) {
        this.list_style = false;
      } else {
        this.list_style = true;
      }
    },
    filterPayment() {
      return this.payments.filter((item) => {
        return item.payment_id.match(this.payment_id_search);
      });
    },
    calculateTotal() {},

    yearRanges() {
      const currentYear = new Date().getFullYear();
      const nextYear = currentYear + 1;
      const yearRanges = [
        `${currentYear - 1}-${currentYear}`,
        `${currentYear}-${nextYear}`,
      ];

      return yearRanges;
    },
    choosePaymentType() {
      if (this.form.selectedPaymentType == "Cash") {
        this.bankChoose = false;
        this.showBankField = false;
      } else if (this.form.selectedPaymentType == "Cheque") {
        this.bankChoose = true;
        this.showBankField = true;
      }
    },
    calculateDate(){
        if(this.form.date>=this.form.basic_date){
            this.excess_receive = false;

        }else{
             this.excess_receive = true;
             this.excess_receive_msg = "Return Date Can't Be Earlier Than Purchase Date !! Purchase Date is:"+this.form.basic_date;
        }
    }
  },
};
</script>
<style>
label {
  margin-right: 1em;
}
.hkf_text {
  color: #000000cf !important;
  font-weight: bold;
}
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
#status {
  color: black;
}

#status option:active {
  background-color: #6e6c8b !important;
  color: #fff;
}
.text-danger {
  color: #e74a3b !important;
  font-size: 1em;
}
.listStyle {
  display: none !important;
}
.ulShow {
  overflow-y: scroll;
  height: 150px;
  display: block;
}
.listShow {
  display: block;
  cursor: pointer;
  padding: 0.2rem;
  color: #4e3089;
}
</style>
