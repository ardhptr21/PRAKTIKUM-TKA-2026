from locust import HttpUser, task, between


class TokoKitaUser(HttpUser):
    wait_time = between(1, 3)

    @task(4)  # 80%
    def browse_catalogue(self):
        self.client.get("/catalogue")

    @task(1)  # 20%
    def checkout(self):
        self.client.post(
            "/checkout",
            json={
                "user": "rootkids",
                "product_id": 1,
                "quantity": 1,
            },
        )
