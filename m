Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204853;
	b=M3NHQIsmjdLXawP+B3Fpwn+0KJj4ZLWQSTlxqUquQNsBqw+4hkHL9oMuRxz9Gb1zTlaj
	 k72/ESC+gC1xuLdCKVxvJnwNiiiXMfJJCT63+7br/Vjzd6V+qQg1pdImsAcT0pVB6OsCv
	 F1nyc3xtXM3Lk7D1MMCK5h64pqAw7zx86QDWPL7ZAqTRRV7+1Xi1kJHr7b8u92QkAXoEJ
	 Pngy3wuz+K0NPSejtyNnP0BDAuUB+iPdjKoNawIOAmKNQmgg04BoSSE6GcW9M8O1Z9UWb
	 ZFxLCc+aphy9TjuMddlIUoHfO/GLjhHLLgm6LPruimHkynuj6noYO0Tdq76B/buPIdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204853;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=/m7QX0MMTGSxU0bG0QEp/4omiyEwy7oV0W7FuQX52lg=;
	b=Aj4b1/1G0OViRoupBTA1j1rHNnjQaScAZzuTskQ5uJm3yaHzcksvxQDRbl2LqHHhn3E/
	 ASanbo44yfh6yNMf0Xmthsdmw9dBZYitiNX87IPUb1OWcJf8un2LbZSfXMI5hMAUJJTDq
	 TqjL7pcjnScSMyumyXLsa4qm2rf5JvF1dsQQ7LXkFDqbT5g+4GBt5Djy0oQ31fG0AHHZj
	 xWlz36hMMHYBgCBgOHOtZy3KMY9OZfrCzXApZgjmALt3BuvS5Uite8Kw/HJEz1MtoZ8Y3
	 BnQbbeF1q3D0pO3az7cP3QGozYzWplEfyl+ZO4P02CMELe9LAcFutGlmNn4OcOEIBRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VdLnPdHQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0040606A334
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0040606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VdLnPdHQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795204850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/m7QX0MMTGSxU0bG0QEp/4omiyEwy7oV0W7FuQX52lg=;
	b=VdLnPdHQXA6YBHc8nzH5xfNlVP+9Yp+NqRHs+kt/tw5pB35fxcV+fuo6mLTNBHwjgF+bee
	SEPKrWmkydYBzNRFMbh4DX+3wgHtOZQKfK8kxX1dRp3JKwha/G8nvNkHjIG+vQSAvZrb7/
	nCtt8Cr1/fHag4ksIzJ5M6rCJnIA0g0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-JFemEfqgMSaMmg7sHaWV4A-1; Fri,
 20 Nov 2026 20:00:45 +0000
X-MC-Unique: JFemEfqgMSaMmg7sHaWV4A-1
X-Mimecast-MFC-AGG-ID: JFemEfqgMSaMmg7sHaWV4A_1795204844
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 799EE1801201
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:44 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD3295B1;
	Fri, 20 Nov 2026 20:00:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCHv2 RESEND v7.4-rc3 2/5] dlm: reject wrapped messages with oversized inner lengths
Date: Fri, 20 Nov 2026 15:00:37 -0500
Message-ID: <20261120200040.257152-3-aahringo@redhat.com>
In-Reply-To: <20261120200040.257152-1-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZZWm4yxCn-JV5alP069Pi4bnWYa-CmI3G8U0C9j8U8M_1795204844
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Reject DLM_OPTS packets whose wrapped inner message length exceeds the
bytes remaining inside the validated outer packet. This keeps malformed
wrapped RCOM replies from reaching downstream length-driven copies.

Fixes: 489d8e559c65 ("fs: dlm: add reliable connection if reconnect")
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

