Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C14078E1
	for <gfs2@lists.linux.dev>; Fri,  2 Oct 2026 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983294; cv=none; b=bE5E3eqyb7kJbH1bow42ZntaFGpoa+Cgai0atrORrIJpyftPVr+2F/oQCyUXUbwFV+bA1i8G5aaeIRgD6CquTRWdTjEzvJUFdkb8C/d9t3ksN9gL/bihBPath2U+/lxkwuvvHvwZREwpzxQvTAjgNwJ/OJn7QkKESiwiB7K8hDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983294; c=relaxed/simple;
	bh=5Lb0/lDMffj/b02e1UiB7wo0x/569zQsLED8t7ItdK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hPYXK6OZl6nAf899WBn9Ii1xssc8X0FNWxumLetrBtDGn/WorwU+U40LKhJstW4E7cu2mJwI6pxxCrKEdyKbjfEyQvtpHma3YdQZ5lJVZEUHz7xtVGXFw1U70U/+TGRwySo2hxhMsQt1/wOAVrHVKe2LqXcSZQSt9IlL566epqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyxObxgv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyxObxgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790983289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rvILOnMQZr4NgL2p44ADtnorUZw5+MPOxfGudk/CUE=;
	b=NyxObxgvwzStb7mQFwau0zlaaWBP++NQY3OgDq4JIWLmeUSg3yWXEPA52XVJOfnFn0/DTJ
	jxaTBVUOrGYRBrnGwUpGBUucOX+7kHj2wIWEddVAzxtFeUiNhtgyvnrg2wmEuFNSn+J+pn
	PCzzsCy/VcNiNZo+r1nfyi5XjjTV+CM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-NiIFWrTbOA63swe4ouOwdg-1; Fri,
 02 Oct 2026 19:21:21 -0400
X-MC-Unique: NiIFWrTbOA63swe4ouOwdg-1
X-Mimecast-MFC-AGG-ID: NiIFWrTbOA63swe4ouOwdg_1790983276
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D617B1956069;
	Fri,  2 Oct 2026 23:21:15 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2B1741B;
	Fri,  2 Oct 2026 23:21:14 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: edumazet@kernel.org
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC 1/2] dlm: drop setting SOCK_NOSPACE
Date: Fri,  2 Oct 2026 19:21:06 -0400
Message-ID: <20261002232107.1578646-2-aahringo@redhat.com>
In-Reply-To: <20261002232107.1578646-1-aahringo@redhat.com>
References: <20261002232107.1578646-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: mwN21sovUL677ViobRsATKp40a2ToUMrTTDdX18Vsn4_1790983276
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It makes no sense to set SOCK_NOSPACE here when we have already
checked for it.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6aa68a24acab..c3a414d2e32b 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1391,10 +1391,6 @@ static int send_to_sock(struct connection *con)
 		spin_lock_bh(&con->writequeue_lock);
 		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
-			/* Notify TCP that we're limited by the
-			 * application window size.
-			 */
-			sk_set_nospace(con->sock->sk);
 			con->sock->sk->sk_write_pending++;
 
 			clear_bit(CF_SEND_PENDING, &con->flags);
-- 
2.43.0

