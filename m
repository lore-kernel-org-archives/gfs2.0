Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997643;
	b=MogPvus5w1kEnMUaJyANsnM2J2bwLOFAwXDxe0NN6HVyIId3z8kNL/lRjZtygCGwcNNL
	 sxLCDMUCxaMPbhGG0u7Mm8OYHKlz9lxzofjezGEPaMi+1qrAwHlCWpXgZTqJpdkQOrQj9
	 jREvkxQF26G6ta0mELnh2HEGJ8k19vPwMcihULLepjcjX+mnik1ILyjuyVD8QSjJmvE6E
	 9qrPaPstlU3yaV4XNE9xB/jUnLyInSQrk06PMzuCIqig1di2iiMDZqn+hyzTOu63Ui2+5
	 Nd6tYPbVNjxccfHZ54cWqE8oRuMkG/6S4r5wb3BGzqnqmbcB8kAGxxJ1hjDgupSPH7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997643;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=lk/yjeBtxKxnSFGDNaYLJ9hy+67GMk4pj0dxtGuiIZI=;
	b=CA1aMRIXVChB2+9G9vbe2hFPJj/5O+CkdiVwMK62D7ipq1ybsx+g4alS4mykLJVqeJmu
	 Zm+C5gD4Ad+xQDDWKqnph2gGRNtsZGizVpYVj5DYM6iSvzopxRJ4pG8EOCZJ7uvBwLltV
	 kGOq1FySx0SeCiati1Q1KfbIiQZY3/Xmda5S99E4BT+VLX5/c5j2jWn4G+EJwotDVc6Pz
	 LlXc0tZCO9XSjLzJLjkR9L5zXHGFoC2WJppvSIWQSzjrLyiWDQvug1MW7lzstIchuZJk9
	 ZbIuRULNScg8QJ8i+QAw9rqiWwFeZGAQZIOtw3M4z5ySkR1JJtZ4tkX2GBJI8sbQmKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J3lvYImY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7C606A329
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J3lvYImY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk/yjeBtxKxnSFGDNaYLJ9hy+67GMk4pj0dxtGuiIZI=;
	b=J3lvYImYjSMd0hmuqpb40+xClBoxLxoWNvMHNkDqJTyH7o5zX9IoqltbvQWuBfv8iujf3f
	Fce+YxO74wP/RLNLcn5NzWaU0O5HO0uWMlRs4iyqntrAF6xy/1ig7fzGjnU9gMadmXqBcY
	HiQoARQ0hS2sEq/Qvi2HF0n6Vk4ld3Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-JDz8H6yDNImfAASjsw35cg-1; Fri,
 06 Nov 2026 15:40:40 -0500
X-MC-Unique: JDz8H6yDNImfAASjsw35cg-1
X-Mimecast-MFC-AGG-ID: JDz8H6yDNImfAASjsw35cg_1793997639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A41DA1955BCC
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:39 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09E681956047;
	Fri,  6 Nov 2026 20:40:38 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.4-rc1 1/4] dlm: reject wrapped messages with oversized inner lengths
Date: Fri,  6 Nov 2026 15:40:32 -0500
Message-ID: <20261106204035.3794411-2-aahringo@redhat.com>
In-Reply-To: <20261106204035.3794411-1-aahringo@redhat.com>
References: <20261106204035.3794411-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 976UM15e-_EmCdCcXWAXeIeM9gVn8EXeK5XMngKbh_M_1793997639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Reject DLM_OPTS packets whose wrapped inner message length exceeds the
bytes remaining inside the validated outer packet. This keeps malformed
wrapped RCOM replies from reaching downstream length-driven copies.

Fixes: 489d8e559c65 ("fs: dlm: add reliable connection if reconnect")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/midcomms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 045431524494..488a58f2c00b 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -652,6 +652,14 @@ static int dlm_opts_check_msglen(const union dlm_packet *p, uint16_t msglen,
 		return -1;
 	}
 
+	p = (const union dlm_packet *)((const unsigned char *)p->opts.o_opts +
+				       le16_to_cpu(p->opts.o_optlen));
+	if (le16_to_cpu(p->header.h_length) > len) {
+		log_print("inner msg too large: %u > %d, will skip this message from node %d",
+			  le16_to_cpu(p->header.h_length), len, nodeid);
+		return -1;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

