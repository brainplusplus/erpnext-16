FROM frappe/erpnext:v16.13.3

USER root
# Install common missing build dependencies just in case Python packages need compilation
RUN apt-get update && \
    apt-get install -y gcc g++ make git && \
    rm -rf /var/lib/apt/lists/*

USER frappe
WORKDIR /home/frappe/frappe-bench

# Install custom apps with --skip-assets
# We skip building assets per-app to prevent intermediate yarn failures and OOM errors
RUN bench get-app https://github.com/frappe/hrms --branch v16.4.8 --skip-assets && \
    bench get-app https://github.com/frappe/crm --branch v1.66.2 --skip-assets && \
    bench get-app https://github.com/frappe/lms --branch v2.52.0 --skip-assets && \
    bench get-app https://github.com/frappe/helpdesk --branch v1.22.1 --skip-assets && \
    bench get-app https://github.com/frappe/meet --branch develop --skip-assets && \
    bench get-app https://github.com/frappe/drive --branch v0.3.0 --skip-assets && \
    bench get-app https://github.com/frappe/waba_integration --branch main --skip-assets && \
    bench get-app https://github.com/ERPGulf/changai --branch main --skip-assets

# Build frontend assets for all apps
RUN bench build --hard-link
