from flask import Blueprint, render_template


customer_web_bp = Blueprint("customer_web", __name__)


@customer_web_bp.get("/join")
def join_queue_page():
    return render_template("join_queue.html")
