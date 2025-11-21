# 🚀 Quick Deployment Instructions

## ✅ What I've Done For You

I've updated your code with:
- ✅ **AI Technology Risk Assessment branding** (with emojis 🤖🛡️)
- ✅ **Automated deployment scripts**
- ✅ **System prompt specialized for risk assessment**
- ✅ **All changes committed to Git**

---

## 🎯 What You Need to Do (Just 3 Steps!)

### **Step 1: Pull Latest Changes**

On your local computer, open PowerShell and run:

```powershell
cd D:\GSO_TRA_sample-app-aoai-chatGPT
git pull origin main
```

### **Step 2: Run the Deployment Script**

Just run this **ONE COMMAND**:

```powershell
.\deploy-all.ps1
```

This script will:
1. ✅ Deploy code to Azure
2. ✅ Configure all UI settings
3. ✅ Set up the branding automatically

**That's it!** Wait 60 seconds and your app will be live with the new branding.

---

## 📱 Your App URL

After deployment, visit:
```
https://trawebappfrommicrosoft-gqh7cjb0gcd0bshp.canadacentral-01.azurewebsites.net/
```

You should see:
- 🤖 **Title:** "🤖 AI Technology Risk Assessment"
- 💬 **Chat Title:** "🤖 AI Risk Assessment"
- 📝 **Description:** "🛡️ This AI assistant helps with technology risk assessment"

---

## 🛠️ Alternative: Manual Deployment

If the automated script doesn't work, you can deploy manually:

### **Option A: Code Only**
```powershell
.\deploy-to-azure.ps1
```
Then manually add settings in Azure Portal.

### **Option B: Settings Only**
```powershell
.\configure-azure-settings.ps1
```
This configures all UI branding settings.

---

## 📋 What Changed

### **Files Modified:**
- `.env.sample` - Added UI branding configuration

### **Files Added:**
- `deploy-all.ps1` - Complete deployment automation
- `deploy-to-azure.ps1` - Code deployment script
- `configure-azure-settings.ps1` - Settings configuration script
- `DEPLOYMENT_INSTRUCTIONS.md` - This file

### **Settings Configured:**
```bash
UI_TITLE=🤖 AI Technology Risk Assessment
UI_CHAT_TITLE=🤖 AI Risk Assessment
UI_CHAT_DESCRIPTION=🛡️ This AI assistant helps with technology risk assessment
UI_SHOW_SHARE_BUTTON=True
UI_SHOW_CHAT_HISTORY_BUTTON=True
AZURE_OPENAI_SYSTEM_MESSAGE=You are an AI assistant specialized in technology risk assessment...
```

---

## ❓ Troubleshooting

### Issue: "Azure remote not found"

The script will ask to configure it. Choose "Y" and it will set it up automatically.

### Issue: "403 Authentication failed"

You'll be prompted for deployment credentials:
- **Username:** From Azure Portal → Deployment Center → Local Git/FTPS credentials
- **Password:** From the same location

### Issue: "Azure CLI not found"

The script will show manual steps to add settings in Azure Portal.

---

## 🎉 Next Steps

Once deployed:

1. **Test the app** - Send a few messages
2. **Enable chat history** - Add CosmosDB (optional)
3. **Add file upload** - For images/PDFs (optional)
4. **Enable authentication** - Set `AUTH_ENABLED=True` (recommended for production)

---

## 💡 Need Help?

Check the detailed guides:
- `BEGINNER_DEPLOYMENT_GUIDE.md` - Step-by-step beginner guide
- `DEPLOYMENT_GUIDE_PORTAL.md` - Azure Portal deployment guide
- `QUICK_DEPLOYMENT_CHECKLIST.md` - Quick reference

---

**Happy deploying!** 🚀
