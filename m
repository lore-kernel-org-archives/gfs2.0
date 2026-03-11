Received: from omggw2001-vm0.mail.snz.yahoo.co.jp (omggw2001-vm0.mail.snz.yahoo.co.jp [124.83.188.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF3299A84
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.83.188.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197785; cv=none; b=eqwx/k2LcztcMLOp0gMMkUG2UOhM4pnTmxo/aetoypZSwVxyLk6i6C7sGK0SnwPWxQ9NQvZ5PJQy62OfR1VfNwNo0nKXX538TZkDwH5ek2yXIBfWWF5REd1D0/D05aSRPpgSAbH11pcw0D96awleuEFyus6IMhKg3hjYBnqH7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197785; c=relaxed/simple;
	bh=7qTFlSQYjDvv4CndiZv8fQP3vWzXOkpwChzhzcFqr+w=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rgm9KcyQxBa2QFzr2LaFWATEJXkX2N9M2CK47+Oz1uj64y/J6ijOEk4RGj7x1h1dO7Bq0hXXYd9SiO+cNbhGWDVXlsFqLcFOs74h0Y8cf/n6TEaSagYxMEI8FuW4He9kvt84ZVg3iMrWfD8zHiJioRFMPsqWgppqA8GtmXWyV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ymail.ne.jp; spf=pass smtp.mailfrom=ymail.ne.jp; dkim=pass (2048-bit key) header.d=ymail.ne.jp header.i=@ymail.ne.jp header.b=K9vrH16p; arc=none smtp.client-ip=124.83.188.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ymail.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.ne.jp header.i=@ymail.ne.jp header.b="K9vrH16p"
X-YMail-OSG: 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
X-Sonic-MF: can-yildirim@ymail.ne.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by sonicconh5102.mail.kks.ynwp.yahoo.co.jp with HTTP; Wed, 11 Mar 2026 02:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773192682;
	s=ymailnejp-202506; d=ymail.ne.jp;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:To:Reply-To:From:Date;
	bh=hj2tP3BtZVowe/LVZfW8Xzq8z00EvqFOBSwZcV6Hn9k=;
	b=K9vrH16pGqjKDXR0hR9q7SdH6n05OOHZCpjFr9qwPh9M+d/0B24QCHEIqXdLtBud
	06cLc+um7eE8Qa9xw6L7YXfOHLAw/9EpeMmpvAIguSkHTD9fxvMebWswzJ6udy6Ptbx
	Sc+gKQ9gsidy4QyQsAgnhFUaG3wHWbELw/4yAEf1qY6DQTVlOjRTSwCAL5mmx662ZZC
	LK5MKO/W3h/aOCtz5qbcykq45YXSNQwkImRihmlbjZytwT1WizDHncuMJ2BIi16onoX
	wVXcDVOz7C+1lPmmtFk16vnu+fG/UaSNH8JDxej91FrEJgrss5Drwe+Si6iP8YU036A
	0wRzuxe+yw==
Date: Wed, 11 Mar 2026 10:31:22 +0900 (JST)
From: can-yildirim@ymail.ne.jp
Reply-To: can-yildirim@ymail.ne.jp
To: "security@kernel.org" <security@kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"aahringo@redhat.com" <aahringo@redhat.com>,
	"teigland@redhat.com" <teigland@redhat.com>
Message-ID: <2098115699.650906.1773192682434@mail.yahoo.co.jp>
In-Reply-To: <173757593.643632.1773164229041@mail.yahoo.co.jp>
References: <173757593.643632.1773164229041.ref@mail.yahoo.co.jp> <173757593.643632.1773164229041@mail.yahoo.co.jp>
Subject: Re: [vs] DLM debugfs information disclosure via non-null-terminated
 resource name
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear maintainers,
There is an possible information disclosure vulnerability in the DLM
subsystem's debugfs interface. The issue resides in the function
print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
byte, the %s format specifier in a seq_printf call reads beyond
the intended buffer, exposing adjacent kernel memory.
Description:
When printing lock information in format 2, the code does:
seq_printf(s, "... "%s"\n", r->res_name);
The res_name field is a fixed-size byte array of length
r->res_length (bounded by DLM_RESNAME_MAXLEN) and is not
guaranteed to be null-terminated. If an attacker creates a resource
with a name of maximum length consisting entirely of non-null bytes
(e.g., 64 'A's), the %s formatter will continue reading past the
end of the res_name buffer until it encounters a null byte in
kernel memory. This leaks the contents of the following memory,
which may include kernel pointers, slab metadata, or other sensitive
data.
Impact:
Local attacker on a system where
DLM is used (e.g., clustered servers running GFS2/OCFS2 with
dlm_controld) can read kernel memory beyond the resource name.
This defeats KASLR, reveals heap layout, and may expose credentials
or other secrets. The leak is a classic information disclosure that
can be used as a building block for further privilege escalation.
Initially;
Create a DLM lockspace (e.g., via dlm_tool join test_ls).
Acquire a lock on a resource with a 64-byte name of non-null
bytes (e.g., 64 'A's) using dlm_ls_lock_wait.
Read /sys/kernel/debug/dlm/test_ls/locks (format 2).
Observe the 64 'A's followed by disclosed kernel memory.
Proposed fix:
Perhaps replacing the unbounded %s with a bounded %.*s using the known
resource length.
Side_Note: The exact line numbers
may vary. Thinking of an usage like; %.*s with r->res_length to
limit the output to the actual name length. Proper tabs should be
used though.

CVE request:
Please assign a CVE ID for this vulnerability if applicable.
 
Thank you for your attention. Please let me know if you need any
further information.
Best regards,
Fatih Can Yildirim 

