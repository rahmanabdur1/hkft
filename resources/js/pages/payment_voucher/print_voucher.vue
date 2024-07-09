<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <h2 class="hkf_title mb-2">
        Receipt Voucher: <span>{{ form.payment_id }}</span>
      </h2>
      <div class="row">
        <div class="col-md-10 mx-auto">
          <button
            type="button"
            class="btn action_print"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <div id="print-container">
          <div style='display:flex;border-bottom:1px solid black;' class='mb-3' >
          <div class="sidebar-brand-icon" style='text-align:left;width:20%;'>
        <img class="logo" :src="'../img/'+avatar" style='width:165%;height:77%;' alt="" />
      </div>
       <div style='padding:5%;width:80%;'>
        <h3 style="text-align: center;">HKF Real Estate LTD</h3>
              <h4 style="text-align: center">
                117/2/8 1st Floor Sopnodanga Residential Area<br>
                Phone: 01400407270  <br>    Email:contact@hkf-re.com <br>
                Website: www.hkf-re.com
              </h4>
      </div>
      </div>
          <hr class="sidebar-divider d-none d-md-block" />
 <span>{{ form.selectedProject }}</span>
            <h3 style="text-align: center">Cash Paid</h3>
            <h3 style="text-align: center; font-weight: bold;">
              FY : {{ form.financialYear }}
            </h3>
            <h5 style="text-align: right">Payment ID: {{ form.payment_id }}</h5>
            <h5 style="text-align: right">Date: {{ form.basic_date }}</h5>
            <table
              style="
                width: 100%;
                border: 1px solid black;
                border-collapse: collapse;
                margin-bottom: 1.5rem;
              " v-if='type_bank'
            >
              <tr
                style="
                  padding: 1.5rem;
                  border: 1px solid black;
                  border-collapse: collapse;
                "
              >
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Payee's Name
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 39%;
                  "
                >
                  {{ form.payee_name }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 35%;
                  "
                >
                  Mobile No:<span style="margin-left: 1rem">{{ form.payee_phone }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Bank Name & A/c No.
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 39%;
                  "
                >
                  {{ form.bank_name }} - account no : {{ form.cash_bank_account }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 35%;
                  "
                >
                  TIN:<span style="margin-left: 1rem">{{ form.payee_tin }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Cheque No.
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 39%;
                  "
                >
                  {{ form.bank_cheque_no }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 35%;
                  "
                >
                  Email:<span style="margin-left: 1rem">{{ form.payee_email }}</span>
                </td>
              </tr>
            </table>
            <table
              style="
                width: 100%;
                border: 1px solid black;
                border-collapse: collapse;
                margin-bottom: 1.5rem;
              " v-if='type_cash'
            >
              <tr
                style="
                  padding: 1.5rem;
                  border: 1px solid black;
                  border-collapse: collapse;
                "
              >
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Payee's Name
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 39%;
                  "
                >
                  {{ form.payee_name }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 35%;
                  "
                >
                  Mobile No:<span style="margin-left: 1rem">{{ form.payee_phone }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Cash In Hand
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 39%;
                  "
                >
                  Cash In Hand
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 35%;
                  "
                >
                  TIN:<span style="margin-left: 1rem">{{ form.payee_tin }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                 Email
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>

                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                 <span style="margin-left: 1rem">{{ form.payee_email }}</span>
                </td>
              </tr>
            </table>
            <h5 style="text-align: left">Received Details:</h5>
            <table
              style="
                width: 100%;
                border: 1px solid black;
                border-collapse: collapse;
                margin-bottom: 1.5rem;
              "
            >
              <tr>
                <th style="border: 1px solid black; text-align: center">
                  Brief Description
                </th>
                <th style="border: 1px solid black; text-align: center">Account Code</th>
                <th style="border: 1px solid black; text-align: center">Amount(TK)</th>
              </tr>
              <tr style="height: 135px">
                <td style="border: 1px solid black; text-align: center">
                  <span style="display: block; margin-left: 1rem; font-weight: bold"
                    >Received:</span
                  >
                  <span style="display: block; margin-left: 1rem; font-weight: 300"
                    >( {{ form.product_name }} )</span
                  >
                </td>
                <td style="border: 1px solid black; text-align: center">
                  <span>Payees Account : </span>
                  {{ form.cash_bank_account }}
                </td>
                <td style="border: 1px solid black; text-align: center">
                  <li
                    v-for="paymentAmount,index in paymentAmounts" :key='index'
                    class="paymentAmounts"
                    style="list-style: none"
                  >
                    {{ paymentAmount }}
                  </li>
                </td>
              </tr>
              <tr style="height: 50px">
                <td style="border: 1px solid black; text-align: center">
                  Total(in word) = {{ word }} Taka Only
                </td>
                <td style="border: 1px solid black; text-align: center">
                  <li class="accountHeads" style="list-style: none">Account Head :</li>
                  <li
                    v-for="account_head,index in account_heads" :key='index'
                    class="accountHeads"
                    style="list-style: none"
                  >
                    {{ account_head }}
                  </li>
                </td>
                <td style="border: 1px solid black; text-align: center">
                  {{ total }} Taka
                </td>
              </tr>
            </table>
            <h5>Note: {{ form.payment_payment_details }}</h5>
          </div>
          <h5>Document:</h5>
          <button
            type="button"
            class="btn action mt-2"
            @click="PrintContent5"
            style="width: 100px"
          >
            Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <div></div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_voucher",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "payment_view_voucher" });
      }
    });
  },
  data() {
    return {
        avatar:'logo.png',
      form: {
        Supporting_docs: "",
        bank_branch: "",
        bank_cheque_date: "",
        bank_cheque_no: "",
        bank_name: "",
        basic_date: "",
        cash_bank_account: "",
        payee_email: "",
        payee_name: "",
        payee_phone: "",
        payee_tin: "",
        financialYear: "",
        payees_account_no: "",
        payto: "",
        product_name: "",
        payment_id: "",
        selectedPaymentType: "",
        selectedProject: "",
        total_amount: "",
        payee_id: "",
        payment_payment_details: "",
      },
      type_bank: false,
      type_cash: false,
      allClients: [],
      mergeReceipt: {
        accountHeads: "",
        paymentAmounts: "",
      },
      selectedClient: {
        name: "",
        father_name: "",
        mother_name: "",
        husban_wife_name: "",
        birth_date: "",
        religion: "",
        occupation: "",
        nationality: "",
        national_id_no: "",
        permanent_location: "",
        permanent_post_office: "",
        permanent_thana: "",
        permanent_district: "",
        temprorary_location: "",
        temprorary_post_office: "",
        temprorary_thana: "",
        temprorary_district: "",
        tin: "",
        phone: "",
        email: "",
        nid_img: "",
        passport_img: "",
        tin_img: "",
        payeeUnderProject: "",
        profile_photos: "",
      },
      account_heads: "",
      paymentAmounts: "",
      project_location: "",
      total: "",
      projects_temp: [],
      number: "",
      word: "",
      ones: [
        "",
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
        "Ten",
        "Eleven",
        "Twelve",
        "Thirteen",
        "Fourteen",
        "Fifteen",
        "Sixteen",
        "Seventeen",
        "Eighteen",
        "Nineteen",
      ],
      tens: [
        "",
        "",
        "Twenty",
        "Thirty",
        "Forty",
        "Fifty",
        "Sixty",
        "Seventy",
        "Eighty",
        "Ninety",
      ],
      thousands: ["", "Thousand", "Million", "Billion", "Trillion"],
    };
  },
  methods: {
    printContent() {
      setTimeout(() => {
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

            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({ name: "payment_all_voucher", params: { id: this.$route.params.id } });
      }, 1500);
    },
    PrintContent5() {

         const file = "../" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        newWindlow.close();
        if (newWindlow.close()) {
          this.$router.push({
            name: "payment_all_voucher",
            params: { id: this.$route.params.id },
          });
        }
      };

    },
    convertToWord() {
      let number = this.number;
      let word = "";

      if (number === 0) {
        word = "zero";
      } else {
        if (number < 0) {
          word = "negative ";
          number = Math.abs(number);
        }

        let i = 0;
        while (number > 0) {
          if (number % 1000 !== 0) {
            word =
              this.convertLessThanOneThousand(number % 1000) +
              " " +
              this.thousands[i] +
              " " +
              word;
          }
          number = Math.floor(number / 1000);
          i++;
        }
      }

      this.word = word.trim();
    },

    convertLessThanOneThousand(number) {
      let word = "";

      if (number % 100 < 20) {
        word = this.ones[number % 100];
        number = Math.floor(number / 100);
      } else {
        word = this.ones[number % 10];
        number = Math.floor(number / 10);

        word = this.tens[number % 10] + word;
        number = Math.floor(number / 10);
      }

      if (number > 0) {
        word = this.ones[number] + "hundred " + word;
      }

      return word;
    },
    downloadFile() {
      const fileUrl = this.form.Supporting_docs;
      const downloadUrl = `${fileUrl}?download=1`;
      window.open(downloadUrl, "_blank");
    },
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/payment_voucher/" + id)
      .then((res) => {
        this.form = res.data;
        this.total = parseFloat(parseFloat(this.form.total_amount).toFixed(2));
        this.number = parseInt(this.form.total_amount);
        this.convertToWord();
        if (this.form.selectedPaymentType == "Cheque") {
          this.type_bank = true;
        } else if (this.form.selectedPaymentType == "Cash") {
          this.type_cash = true;
        }
      })
      .catch((err) => {
      });

    axios
      .get("/api/payment_voucher_single/" + id)
      .then((res) => {
        this.mergeReceipt = res.data;
        this.account_heads = this.mergeReceipt.accountHeads.split(",");
        this.paymentAmounts = this.mergeReceipt.paymentAmounts.split(",");
      })
      .catch((err) => {
      });
    this.convertToWord();
    this.convertLessThanOneThousand();
    this.printContent();
  },
};
</script>
<style>
h1,
h2,
h3,
h4,
h5,
h6 {
  color: black;
}
.accountHeads {
  color: #473b5edb;
  font-size: 1em;
}
.paymentAmounts {
  color: white;
  font-size: 1em;
}
</style>

